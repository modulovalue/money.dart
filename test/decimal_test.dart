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
import "package:money/money.dart";
import "package:test/test.dart";

final amount = "10101010101010101010101010101010101010.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000030000003000000000000000001";
final anotherAmount = "10101010101010101010101010101010101010.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000030000003000000000000000001";

final currency = new IAINCurrency(type: "CR", id: 1, preferredExponent: 8);
final anotherCurrency = new IAINCurrency(type: "CR", id: 2, preferredExponent: 8);

final money1 = new Money(Decimal.parse(amount), currency);
final anotherMoney1 = new Money(Decimal.parse(anotherAmount), currency);
final money2 = new Money(Decimal.parse(amount), anotherCurrency);
final anotherMoney2 = new Money(Decimal.parse(anotherAmount), anotherCurrency);

void main() {
    final eur = new CodeCurrency(code: "EUR", preferredExponent: 8);
    final usd = new CodeCurrency(code: "USD", preferredExponent: 8);
    final jpy = new CodeCurrency(code: "JPY", preferredExponent: 8);
    final btc = new CodeCurrency(code: "BTC", preferredExponent: 8);

    var EURUSD = new ExchangeRate(
        value: Decimal.parse("1.17"),
        base: eur,
        inCurrency: usd,
    );


    var USDJPY = new ExchangeRate(
        value: Decimal.parse("110"),
        base: usd,
        inCurrency: jpy,
    );

    var JPYBTC = new ExchangeRate(
        value: Decimal.parse("0.0000014"),
        base: jpy,
        inCurrency: btc,
    );

    var EURJPY = EURUSD.to(USDJPY);
    var EURBTC = EURUSD.to(USDJPY).to(JPYBTC);

    group("Money", () {
        test("has an amount", () {
            expect(EURUSD.inverse().toString(), "0.8547008547");
            expect(USDJPY.inverse().toString(), "0.0090909091");
            expect(JPYBTC.inverse().toString(), "714285.7142857143");
        });
    });

    Currency iainCurrency = new IAINCurrency(type: "CR", id: 2, preferredExponent: 5);
    ConvertableExchangeRateRepository convertable
    = new ConvertableExchangeRateRepository(
        new SingleExchangeRateRepository(
            base: eur,
            rates: [
                EURUSD,
                EURJPY,
                EURBTC,
                new ExchangeRate(value: Decimal.parse("0.00000012345"), base: eur, inCurrency: iainCurrency),
                new ExchangeRate.identity(currency: eur),
            ]
        ),
    );

    group("ExchangeRateRepository", () {
        test("has an amount", () {
            ConvertableExchangeRateRepository usdMode = convertable.rebase(usd);
            ConvertableExchangeRateRepository btcMode = convertable.rebase(btc);
            ConvertableExchangeRateRepository jpyMode = convertable.rebase(jpy);
            ConvertableExchangeRateRepository eurMode = convertable.rebase(eur);
            ConvertableExchangeRateRepository iainCurMode = convertable.rebase(iainCurrency);
            print(usdMode.toDebug());
            print("\n");
            print(btcMode.toDebug());
            print("\n");
            print(jpyMode.toDebug());
            print("\n");
            print(eurMode.toDebug());
            print("\n");
            print(iainCurMode.toDebug());
            print("\n");
        });
    });
}