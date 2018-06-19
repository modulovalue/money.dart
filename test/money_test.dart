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

final amount = 10;
final anotherAmount = 5;
final currency = new CodeCurrency(code: "USD");
final anotherCurrency = new CodeCurrency(code: "EUR");
final money = new Money(new Decimal.fromInt(amount), currency);

void main() {
    group("Money", () {
        test("has an amount", () {
            print(money.amount);
            print(amount.toString());
            expect(money.amount.toString(), equals(amount.toString()));
        });

        test("has a currency", () {
            expect(money.currency, same(currency));
        });

        test("throws an error when amount is null during instantiation", () {
            expect(() => new Money(null, currency), throwsArgumentError);
        });

        test("throws an error when currency is null during instantiaion", () {
            expect(() => new Money(new Decimal.fromInt(1), null), throwsArgumentError);
        });

        test("tests currency equality", () {
            expect(money.isSameCurrency(new Money(new Decimal.fromInt(amount), currency)), isTrue);
            expect(money.isSameCurrency(new Money(new Decimal.fromInt(anotherAmount), currency)), isTrue);
            expect(money.isSameCurrency(new Money(new Decimal.fromInt(amount), anotherCurrency)), isFalse);
        });

        test("equals to another money", () {
            expect(money == new Money(new Decimal.fromInt(amount), currency), isTrue);
            expect(money == new Money(new Decimal.fromInt(amount + 1), currency), isFalse);
            expect(money == new Money(new Decimal.fromInt(amount - 1), currency), isFalse);
            expect(money == new Money(new Decimal.fromInt(amount), anotherCurrency), isFalse);
            expect(money == "not a money", isFalse);
        });

        test("has a hashcode", () {
            expect(money.hashCode, const isInstanceOf<int>());
            expect(money.hashCode, equals(new Money(new Decimal.fromInt(amount), currency).hashCode));
            expect(money.hashCode, isNot(equals(new Money(new Decimal.fromInt(amount + 1), currency).hashCode)));
            expect(money.hashCode, isNot(equals(new Money(new Decimal.fromInt(amount - 1), currency).hashCode)));
            expect(money.hashCode, isNot(equals(new Money(new Decimal.fromInt(amount), anotherCurrency).hashCode)));
        });

        test("has comparators", () {
            expect(new Money(new Decimal.fromInt(0), currency).isZero, isTrue);
            expect(new Money(new Decimal.fromInt(0), currency).isPositive, isFalse);
            expect(new Money(new Decimal.fromInt(0), currency).isNegative, isFalse);
            expect(new Money(new Decimal.fromInt(1), currency).isZero, isFalse);
            expect(new Money(new Decimal.fromInt(1), currency).isPositive, isTrue);
            expect(new Money(new Decimal.fromInt(1), currency).isNegative, isFalse);
            expect(new Money(new Decimal.fromInt(-1), currency).isZero, isFalse);
            expect(new Money(new Decimal.fromInt(-1), currency).isPositive, isFalse);
            expect(new Money(new Decimal.fromInt(-1), currency).isNegative, isTrue);
        });

        group("compares two amounts", () {
            test("(both are equal)", () {
                final another = new Money(new Decimal.fromInt(amount), currency);
                expect(money.compareTo(another), equals(0));
                expect(money < another, isFalse);
                expect(money <= another, isTrue);
                expect(money > another, isFalse);
                expect(money >= another, isTrue);
            });

            test("(the first is less than the second)", () {
                final another = new Money(new Decimal.fromInt(amount + 1), currency);
                expect(money.compareTo(another), equals(-1));
                expect(money < another, isTrue);
                expect(money <= another, isTrue);
                expect(money > another, isFalse);
                expect(money >= another, isFalse);
            });

            test("(the first is greater than  the second)", () {
                final another = new Money(new Decimal.fromInt(amount - 1), currency);
                expect(money.compareTo(another), equals(1));
                expect(money < another, isFalse);
                expect(money <= another, isFalse);
                expect(money > another, isTrue);
                expect(money >= another, isTrue);
            });
        });

        test("throws an error when currency is different during comparison", () {
            final another = new Money(new Decimal.fromInt(amount), anotherCurrency);
            expect(() => money.compareTo(another), throwsArgumentError);
            expect(() => money < another, throwsArgumentError);
            expect(() => money <= another, throwsArgumentError);
            expect(() => money > another, throwsArgumentError);
            expect(() => money >= another, throwsArgumentError);
        });

        test("throws an error when operand is null during comparison", () {
            expect(() => money.compareTo(null), throwsArgumentError);
            expect(() => money < null, throwsArgumentError);
            expect(() => money <= null, throwsArgumentError);
            expect(() => money > null, throwsArgumentError);
            expect(() => money >= null, throwsArgumentError);
        });

        test("adds anoher money", () {
            final result = new Money(new Decimal.fromInt(amount), currency) +
                new Money(new Decimal.fromInt(anotherAmount), currency);
            expect(result, const isInstanceOf<Money>());
            expect(result.amount.toString(), equals((amount + anotherAmount).toString()));
            expect(result.currency.toString(), equals(currency.toString()));
        });

        test("throws an error when operand is null during addition", () {
            expect(() => money + null, throwsArgumentError);
        });

        test("throws an error when currencies are different during addition", () {
            expect(() => money + new Money(new Decimal.fromInt(amount), anotherCurrency), throwsArgumentError);
        });

        test("subtracts another money", () {
            final result = new Money(new Decimal.fromInt(amount), currency) -
                new Money(new Decimal.fromInt(anotherAmount), currency);
            expect(result, const isInstanceOf<Money>());
            expect(result.amount.toString(), equals((amount - anotherAmount).toString()));
            expect(result.currency.toString(), equals(currency.toString()));
        });

        test("throws an error when operand is null during substraction", () {
            expect(() => money - null, throwsArgumentError);
        });

        test("throws an error when currencies are different during subtraction", () {
            expect(() => money - new Money(new Decimal.fromInt(amount), anotherCurrency), throwsArgumentError);
        });

        test("has unary minus operator, which returns money with negative amount", () {
            final zero = new Money(new Decimal.fromInt(0), currency);
            final positive = new Money(new Decimal.fromInt(1), currency);
            final negative = new Money(new Decimal.fromInt(-1), currency);

            expect(-zero, equals(zero));
            expect(-positive, equals(negative));
            expect(-negative, equals(positive));
        });

        test("has a multiplication operator, which multiplies the amount with half-up rounding", () {
            final one = new Money(new Decimal.fromInt(1), currency);

            expect(one * Decimal.parse("2.2"), equals(new Money(Decimal.parse("2.2"), currency)));
            expect(one * Decimal.parse("2.4"), equals(new Money(Decimal.parse("2.4"), currency)));
            expect(one * Decimal.parse("2.5"), equals(new Money(Decimal.parse("2.5"), currency)));
            expect(one * Decimal.parse("2.6"), equals(new Money(Decimal.parse("2.6"), currency)));
            expect(one * Decimal.parse("2"), equals(new Money(new Decimal.fromInt(2), currency)));
            expect(one * Decimal.parse("-3"), equals(new Money(new Decimal.fromInt(-3), currency)));
            expect(one * Decimal.parse("-2"), equals(new Money(new Decimal.fromInt(-2), currency)));
            expect(one * Decimal.parse("-2"), equals(new Money(new Decimal.fromInt(-2), currency)));
            expect(
                one * Decimal.parse("-8328.578947368"), equals(new Money(Decimal.parse("-8328.578947368"), currency)));
            expect(one * Decimal.parse("-8328.5"), equals(new Money(Decimal.parse("-8328.5"), currency)));
        });

        test("throws an error when operand is null during multiplication", () {
            expect(() => money * null, throwsArgumentError);
        });

//        test("has a division operator, which divides the amount with half-up rounding", () {
//            final one = new Money(new Decimal.fromInt(1), currency);
//
//            expect(
//                one / Decimal.parse("1") / Decimal.parse("2.2"), equals(new Money(new Decimal.fromInt(2), currency)));
//            expect(
//                one / Decimal.parse("1") / Decimal.parse("2.4"), equals(new Money(new Decimal.fromInt(2), currency)));
//            expect(
//                one / Decimal.parse("1") / Decimal.parse("2.5"), equals(new Money(new Decimal.fromInt(3), currency)));
//            expect(
//                one / Decimal.parse("1") / Decimal.parse("2.6"), equals(new Money(new Decimal.fromInt(3), currency)));
//            expect(one / Decimal.parse("1") / Decimal.parse("2"), equals(new Money(new Decimal.fromInt(2), currency)));
//            expect(
//                one / Decimal.parse("1") / Decimal.parse("-2.5"), equals(new Money(new Decimal.fromInt(-3), currency)));
//            expect(
//                one / Decimal.parse("1") / Decimal.parse("-2"), equals(new Money(new Decimal.fromInt(-2), currency)));
//            expect(
//                one / Decimal.parse("1") / Decimal.parse("-1.5"), equals(new Money(new Decimal.fromInt(-2), currency)));
//            expect(one / Decimal.parse("1") / Decimal.parse("-8328.578947368"),
//                equals(new Money(new Decimal.fromInt(-8329), currency)));
//            expect(one / Decimal.parse("1") / Decimal.parse("-8328.5"),
//                equals(new Money(new Decimal.fromInt(-8329), currency)));
//        });

        test("throws an error when operand is null during division", () {
            expect(() => money / null, throwsArgumentError);
        });

        test("throws an error when divider is 0 during division", () {
            expect(() => money / new Decimal.fromInt(0), throwsArgumentError);
            expect(() => money / Decimal.parse("0.0"), throwsArgumentError);
        });

        test("allocates amount by ratio", () {
            expect(
                new Money(new Decimal.fromInt(0), currency).allocate([new Decimal.fromInt(1), new Decimal.fromInt(1)]),
                equals(
                    <Money>[new Money(new Decimal.fromInt(0), currency), new Money(new Decimal.fromInt(0), currency)]));
            expect(
                new Money(new Decimal.fromInt(1), currency).allocate([new Decimal.fromInt(1), new Decimal.fromInt(1)]),
                equals(
                    <Money>[new Money(new Decimal.fromInt(1), currency), new Money(new Decimal.fromInt(0), currency)]));
            expect(
                new Money(new Decimal.fromInt(2), currency).allocate([new Decimal.fromInt(1), new Decimal.fromInt(1)]),
                equals(
                    <Money>[new Money(new Decimal.fromInt(1), currency), new Money(new Decimal.fromInt(1), currency)]));
            expect(
                new Money(new Decimal.fromInt(2), currency).allocate([new Decimal.fromInt(1), new Decimal.fromInt(0)]),
                equals(
                    <Money>[new Money(new Decimal.fromInt(2), currency), new Money(new Decimal.fromInt(0), currency)]));
            expect(
                new Money(new Decimal.fromInt(2), currency).allocate([new Decimal.fromInt(0), new Decimal.fromInt(1)]),
                equals(
                    <Money>[new Money(new Decimal.fromInt(0), currency), new Money(new Decimal.fromInt(2), currency)]));
            expect(new Money(new Decimal.fromInt(100), currency).allocate(
                [new Decimal.fromInt(1), new Decimal.fromInt(1), new Decimal.fromInt(1)]),
                equals(<Money>[
                    new Money(new Decimal.fromInt(34), currency),
                    new Money(new Decimal.fromInt(33), currency),
                    new Money(new Decimal.fromInt(33), currency)
                ]));
            expect(new Money(new Decimal.fromInt(101), currency).allocate(
                [new Decimal.fromInt(1), new Decimal.fromInt(1), new Decimal.fromInt(1)]),
                equals(<Money>[
                    new Money(new Decimal.fromInt(34), currency),
                    new Money(new Decimal.fromInt(34), currency),
                    new Money(new Decimal.fromInt(33), currency)
                ]));
            expect(new Money(new Decimal.fromInt(101), currency).allocate(
                [new Decimal.fromInt(3), new Decimal.fromInt(7)]),
                equals(
                    <Money>[new Money(new Decimal.fromInt(31), currency), new Money(new Decimal.fromInt(70), currency)
                    ]));
            expect(new Money(new Decimal.fromInt(101), currency).allocate(
                [new Decimal.fromInt(7), new Decimal.fromInt(3)]),
                equals(
                    <Money>[new Money(new Decimal.fromInt(71), currency), new Money(new Decimal.fromInt(30), currency)
                    ]));
            expect(new Money(new Decimal.fromInt(-101), currency).allocate(
                [new Decimal.fromInt(1), new Decimal.fromInt(1)]),
                equals(
                    <Money>[new Money(new Decimal.fromInt(-50), currency), new Money(new Decimal.fromInt(-51), currency)
                    ]));
            expect(new Money(new Decimal.fromInt(-101), currency).allocate(
                [new Decimal.fromInt(7), new Decimal.fromInt(3)]),
                equals(
                    <Money>[new Money(new Decimal.fromInt(-70), currency), new Money(new Decimal.fromInt(-31), currency)
                    ]));
            expect(new Money(new Decimal.fromInt(-101), currency).allocate(
                [new Decimal.fromInt(3), new Decimal.fromInt(7)]),
                equals(
                    <Money>[new Money(new Decimal.fromInt(-30), currency), new Money(new Decimal.fromInt(-71), currency)
                    ]));
        });

        test("throws an error when ratio is null during allocation", () {
            expect(() => money.allocate(null), throwsArgumentError);
        });

        test("throws an error when list of ratios is empty during allocation", () {
            expect(() => money.allocate([]), throwsArgumentError);
        });

        test("throws an error when any of ratios is null during allocation", () {
            expect(() => money.allocate([new Decimal.fromInt(1), null]), throwsArgumentError);
        });

        test("trows an error when any of ratios less than 0 during allocation", () {
            expect(() => money.allocate([new Decimal.fromInt(4), new Decimal.fromInt(-1)]), throwsArgumentError);
        });

        test("throws an error when sum of ratios is 0", () {
            expect(() => money.allocate([new Decimal.fromInt(0), new Decimal.fromInt(0)]), throwsArgumentError);
        });

        test("allocates amount to N targets", () {
            expect(new Money(new Decimal.fromInt(15), currency).allocateTo(1),
                equals(<Money>[new Money(new Decimal.fromInt(15), currency)]));
            expect(new Money(new Decimal.fromInt(15), currency).allocateTo(2),
                equals(
                    <Money>[new Money(new Decimal.fromInt(8), currency), new Money(new Decimal.fromInt(7), currency)]));
            expect(new Money(new Decimal.fromInt(10), currency).allocateTo(2),
                equals(
                    <Money>[new Money(new Decimal.fromInt(5), currency), new Money(new Decimal.fromInt(5), currency)]));
            expect(new Money(new Decimal.fromInt(10), currency).allocateTo(3),
                equals(<Money>[
                    new Money(new Decimal.fromInt(4), currency),
                    new Money(new Decimal.fromInt(3), currency),
                    new Money(new Decimal.fromInt(3), currency)
                ]));
        });

        test("throws an error when N is null during allocation to the N targets", () {
            expect(() => money.allocateTo(null), throwsArgumentError);
        });

        test("throws an error when N is less than 1 during allocation to the N targets", () {
            expect(() => money.allocateTo(0), throwsArgumentError);
            expect(() => money.allocateTo(-1), throwsArgumentError);
        });
    });
}