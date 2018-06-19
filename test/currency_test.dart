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

import "package:money/money.dart";
import "package:test/test.dart";

final currency = new CodeCurrency(code: "USD");
final anotherCurrency = new CodeCurrency(code: "EUR");

void main() {
    group("Currency", () {
        test("has a code", () {
            expect(currency.code, same("USD"));
        });

        test("throws an error when code is NULL during instantiation", () {
            expect(() => new CodeCurrency(code: null), throwsArgumentError);
        });

        test("throws an error when code is empty during instantiation", () {
            expect(() => new CodeCurrency(code: ""), throwsArgumentError);
            expect(() => new CodeCurrency(code: "  "), throwsArgumentError);
        });

        test("equals to another currency", () {
            expect(currency == currency, isTrue);
            expect(currency == anotherCurrency, isFalse);
            expect(currency == "not a currency", isFalse);
        });

        test("has a hashcode", () {
            expect(currency.hashCode, const isInstanceOf<int>());
            expect(currency.hashCode, equals(new CodeCurrency(code: "USD").hashCode));
            expect(currency.hashCode, isNot(equals(new CodeCurrency(code: "EUR").hashCode)));
        });
    });
}