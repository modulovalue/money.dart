import 'package:decimal/decimal.dart';
import 'package:meta/meta.dart';
import 'package:money/money.dart';


class ExchangeRate {

    Decimal value;
    Currency base;
    Currency inCurrency;

    ExchangeRate({
        @required this.value,
        @required this.base,
        @required this.inCurrency,
    }) {
        if (value == null) {
            throw new ArgumentError.notNull("value");
        }

        if (value == Decimal.parse("0.0")) {
            throw new ArgumentError.value(value.toString(), "value", "the exchange rate can't be zero (0)");
        }
        if (base == null) {
            throw new ArgumentError.notNull("base");
        }
        if (inCurrency == null) {
            throw new ArgumentError.notNull("inCurrency");
        }
        if (base == inCurrency && value != Decimal.parse("1.0")) {
            throw new ArgumentError.value(value.toString(), "value", "Value has to be 1.0 if currenceis are the same");
        }
    }

    ExchangeRate.identity({
        @required Currency currency
    }) {
        if (currency == null) {
            throw new ArgumentError.notNull("currency");
        }
        base = currency;
        inCurrency = currency;
        value = Decimal.parse("1.0");
    }

    ExchangeRate invert() {
        return new ExchangeRate(
            value: inverse(),
            base: inCurrency,
            inCurrency: base,
        );
    }

    Decimal getValue() {
        return value;
    }

    Currency getInCurrency() {
        return inCurrency;
    }

    Currency getBase() {
        return base;
    }

    Decimal inverse() {
        return Decimal.parse("1.0") / getValue();
    }

    ExchangeRate to(ExchangeRate to) {
        if (this.inCurrency != to.base) {
            throw new ArgumentError.value(
                to.base.toDebugString(), "to.base",
                "the to base has to be the same currency as the from original inCurrency");
        }
        return new ExchangeRate(
            value: value * to.value,
            base: base,
            inCurrency: to.inCurrency,
        );
    }

    ExchangeRate rebase(ExchangeRate newBase) {
        if (this.base != newBase.inCurrency) {
            throw new ArgumentError.value(
                newBase.inCurrency.toDebugString(), "newBase.inCurrency",
                "newBase exchange rate isCurrency has to be identical to the old base");
        }

        return new ExchangeRate(
            value: value * newBase.value,
            base: newBase.base,
            inCurrency: inCurrency,
        );
    }

    String toTickers({bool expanded = false}) {
        return ""
            "${expanded ? base.toDebugString() : base.code}"
            "/"
            "${expanded ? inCurrency.toDebugString() : inCurrency.code} ${value.toString().padRight(25)}, "
            "${expanded ? inCurrency.toDebugString() : inCurrency.code}"
            "/"
            "${expanded ? base.toDebugString() : base.code} ${inverse()}\n";
    }

    String toDebug() {
        var a = " 1 (${base.toDebugString()}) = ${value.toString()} (${inCurrency.toDebugString()}), \n";
        a += " 1 (${inCurrency.toDebugString()}) = ${inverse()} (${base.toDebugString()}) \n";
        a += "     " + toTickers(expanded: true);
        a += "\n";
        return a;
    }
}
