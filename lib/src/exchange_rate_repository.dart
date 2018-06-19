
import 'package:meta/meta.dart';
import 'package:money/money.dart';

abstract class ExchangeRateRepository {

    bool hasRateFor(Currency currency);

    bool supportsNewBase(Currency newBase);

    List<Currency> availableCurrencies();

    List<ExchangeRate> allRates();

    ExchangeRateRepository rebase(Currency newBase);

    ExchangeRate rateFor(Currency currency);

    String toDebug() {
        var a = "Exchange rate repository: Currencies ${allRates().length} \n";

        allRates().forEach((f) {
            a += f.toTickers(expanded: true);
        });

        return a;
    }
}

class ConvertableExchangeRateRepository extends ExchangeRateRepository {

    ExchangeRateRepository original;
    ExchangeRateRepository currentRepository;

    ConvertableExchangeRateRepository(this.original) {
        currentRepository = original;
    }

    ConvertableExchangeRateRepository.raw({
        @required this.original,
        @required this.currentRepository,
    });

    @override
    List<ExchangeRate> allRates() {
        return currentRepository.allRates();
    }

    @override
    bool hasRateFor(Currency currency) {
        return currentRepository.hasRateFor(currency);
    }

    @override
    bool supportsNewBase(Currency newBase) {
        return original.hasRateFor(newBase);
    }

    List<Currency> availableCurrencies() {
        return currentRepository.availableCurrencies();
    }

    @override
    ConvertableExchangeRateRepository rebase(Currency newBase) {
        return new ConvertableExchangeRateRepository.raw(
            original: original,
            currentRepository: original.rebase(newBase),
        );
    }

    @override
    ExchangeRate rateFor(Currency currency) {
        return currentRepository.rateFor(currency);
    }
}

class SingleExchangeRateRepository extends ExchangeRateRepository {

    Currency base;
    List<ExchangeRate> rates;

    SingleExchangeRateRepository({
        @required this.base,
        @required this.rates,

    }) {
        if (base == null) {
            throw new ArgumentError.notNull("base");
        }
        if (rates == null) {
            throw new ArgumentError.notNull("rates");
        }
        rates.forEach((f) {
            if (f.base != base) {
                throw new ArgumentError.value(f.base.toDebugString(), "f.base",
                    "passed rates need to have the repositories base");
            }
        });
    }

    @override
    List<Currency> availableCurrencies() => rates.map((f) => f.inCurrency).toList();

    @override
    bool hasRateFor(Currency currency) =>
        rates
            .where((t) => t.inCurrency == currency)
            .length > 0;

    @override
    bool supportsNewBase(Currency currency) => hasRateFor(currency);


    @override
    List<ExchangeRate> allRates() {
        return rates;
    }

    SingleExchangeRateRepository rebase(Currency newBase) {
        var rate = rateFor(newBase).invert();
        return new SingleExchangeRateRepository(
            base: newBase,
            rates: rates.map((f) {
                var ok = f.rebase(rate);
                return ok;
            }).toList(),
        );
    }

    List<ExchangeRate> ratesWithoutIdentity() {
        return rates.where((ExchangeRate e) => (e.base != e.inCurrency)).toList();
    }

    @override
    ExchangeRate rateFor(Currency currency) {
        if (base == currency) {
            return new ExchangeRate.identity(currency: currency);
        } else {
            var filtered = ratesWithoutIdentity().firstWhere((ExchangeRate e) => e.inCurrency == currency,
                orElse: () => null);
            if (filtered == null) {
                throw new ArgumentError.value(
                    currency.toDebugString(), "currency", "currency does now exist in this repository");
            } else {
                return filtered;
            }
        }
    }
}