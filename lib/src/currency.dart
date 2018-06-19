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

import 'package:meta/meta.dart';

/// Currency Value Object.
///
/// Holds Currency specific data.
abstract class Currency {
    /// This currency code.

    String get code;

    int get preferredExponent;

    @override
    bool operator ==(Object other) {
        return other is Currency && other.code == code;
    }

    @override
    int get hashCode {
        return 17 * 37 + code.hashCode;
    }
}


class CodeCurrency implements Currency {

    @override
    final String code;

    @override
    final int preferredExponent;

    CodeCurrency({@required this.code, this.preferredExponent = 2}) {
        if (code == null) {
            throw new ArgumentError.notNull("code");
        }
        if (code
            .trim()
            .isEmpty) {
            throw new ArgumentError.value(code, "code", "Cannot be empty");
        }

        if (preferredExponent == null) {
            throw new ArgumentError.notNull("preferredExponent");
        }
        if (preferredExponent < 0) {
            throw new ArgumentError.value(preferredExponent, "preferredExponent", "Cannot be negative");
        }
    }

    @override
    bool operator ==(Object other) {
        return other is Currency && other.code == code;
    }

    @override
    int get hashCode {
        return 17 * 37 + code.hashCode;
    }
}

class IAINCurrency implements Currency {

    final String type;
    final int id;

    @override
    final int preferredExponent;

    IAINCurrency({
        @required this.type,
        @required this.id,
        @required this.preferredExponent,

    }) {
        if (type == null) {
            throw new ArgumentError.notNull("type");
        }
        if (type
            .trim()
            .isEmpty) {
            throw new ArgumentError.value(type, "type", "Cannot be empty");
        }

        if (id == null) {
            throw new ArgumentError.notNull("id");
        }
        if (id.isNegative) {
            throw new ArgumentError.value(id, "id", "id cannot be negative");
        }

        if (preferredExponent == null) {
            throw new ArgumentError.notNull("preferredExponent");
        }
        if (preferredExponent < 0) {
            throw new ArgumentError.value(preferredExponent, "preferredExponent", "Cannot be negative");
        }
    }

    @override
    String get code => "$type$id";

    @override
    bool operator ==(Object other) {
        return other is Currency && other.code == code;
    }

    @override
    int get hashCode {
        /// TODO
        return super.hashCode;
    }
}
