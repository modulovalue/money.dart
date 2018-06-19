// The MIT License (MIT)
//
// Copyright (c) 2015 - 2016 Roman Shamritskiy
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import 'package:decimal/decimal.dart';
import 'package:money/money.dart';

/// Money value object.
class Money implements Comparable<Money> {
    /// Constructs money value initialized with [amount] and [currency].
    ///
    /// Where [amount] expressed in the smallest units of currency (eg cents).
    Money(this.amount, this.currency) {
        if (amount == null) {
            throw new ArgumentError.notNull("amount");
        }
        if (currency == null) {
            throw new ArgumentError.notNull("currency");
        }
    }

    final Decimal amount;

    final Currency currency;

    bool get isZero => amount == new Decimal.fromInt(0);

    bool get isPositive => amount > Decimal.parse("0.0");

    bool get isNegative => amount < Decimal.parse("0.0");

    /// Checks whether a Money has the same Currency as this.
    bool isSameCurrency(Money another) => currency == another.currency;

    /// Returns `true` if [another] is [Money] with same amount and currency.
    @override
    bool operator ==(Object another) {
        return another is Money &&
            isSameCurrency(another) &&
            amount == another.amount;
    }

    @override
    int get hashCode {
        var result = 17;
        result = result * 37 + amount.hashCode;
        result = result * 37 + currency.hashCode;

        return result;
    }

    @override
    int compareTo(Money another) {
        _assertAcceptableMoneyArgument(another);

        return amount.compareTo(another.amount);
    }

    bool operator <(Money another) {
        return compareTo(another) < 0;
    }

    bool operator <=(Money another) {
        return compareTo(another) <= 0;
    }

    bool operator >(Money another) {
        return compareTo(another) > 0;
    }

    bool operator >=(Money another) {
        return compareTo(another) >= 0;
    }

    Money operator +(Money another) {
        _assertAcceptableMoneyArgument(another);

        return _withAmount(amount + another.amount);
    }

    Money operator -() {
        return _withAmount(-amount);
    }

    Money operator -(Money another) {
        _assertAcceptableMoneyArgument(another);

        return _withAmount(amount - another.amount);
    }

    Money operator *(Decimal multiplier) {
        _assertNotNull(multiplier, "multiplier");

        return _withAmount(amount * multiplier);
    }

    Money operator /(Decimal divider) {
        _assertNotNull(divider, "divider");
        if (divider == 0) {
            throw new ArgumentError.value(
                divider, "divider", "Division by zero is forbidden.");
        }

        return _withAmount(amount / divider);
    }

    List<Money> allocate(List<Decimal> ratios) {
        _assertNotNull(ratios, "ratios");

        final shares = new List<Decimal>(ratios.length);
        final total = _calculateRatiosTotal(ratios);
        var remainder = amount;

        for (var i = 0; i < ratios.length; ++i) {
            var share = (amount * ratios[i] / total).floor();
            remainder -= share;
            shares[i] = share;
        }

        for (var i = 0; remainder > Decimal.parse("0.0"); ++i) {
            shares[i] += Decimal.parse("1.0");
            remainder -= Decimal.parse("1.0");
        }

        return new List<Money>.unmodifiable(shares.map(_withAmount));
    }

    List<Money> allocateTo(int n) {
        _assertNotNull(n, "n");

        if (n < 1) {
            throw new ArgumentError.value(
                n, "n", "Number of targets must not be less than 1");
        }

        return allocate(new List<Decimal>.filled(n, Decimal.parse("1.0")));
    }

    void _assertAcceptableMoneyArgument(Money money, [String name = "other"]) {
        _assertNotNull(money, name);
        _assertSameCurrency(money, name);
    }

    void _assertNotNull(Object arg, String name) {
        if (arg == null) {
            throw new ArgumentError.notNull(name);
        }
    }

    void _assertSameCurrency(Money other, String name) {
        if (!isSameCurrency(other)) {
            throw new ArgumentError.value(other, name, "Currencies must be equal");
        }
    }

    /// Creates new [Money] instance with same [Currency].
    Money _withAmount(Decimal amount) => new Money(amount, currency);


    Decimal _calculateRatiosTotal(List<Decimal> ratios) {
        var total = Decimal.parse("0.0");
        for (var ratio in ratios) {
            if (ratio == null) {
                throw new ArgumentError.value(ratios, "ratios", "Cannon contain null");
            }
            if (ratio < Decimal.parse("0.0")) {
                throw new ArgumentError.value(
                    ratio, "ratios", "Cannot contain a negative value.");
            }
            total += ratio;
        }

        if (total == Decimal.parse("0.0")) {
            throw new ArgumentError.value(
                ratios, "ratios", "Sum of ratios must not be 0");
        }

        return total;
    }

    @override
    String toString() {
        return amount.toString() + " " + currency.toString();
    }
}
