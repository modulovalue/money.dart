// The MIT License (MIT)
//
// Copyright (c) 2016 - 2017 Roman Shamritskiy
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

part of money;

const Map<String, Currency> _currencies = const <String, Currency>{
  'AED': const Currency._private('AED', 'UAE Dirham', 784, 2, 100),
  'AFN': const Currency._private('AFN', 'Afghani', 971, 2, 100),
  'ALL': const Currency._private('ALL', 'Lek', 8, 2, 100),
  'AMD': const Currency._private('AMD', 'Armenian Dram', 51, 2, 100),
  'ANG': const Currency._private('ANG', 'Netherlands Antillean Guilder', 532, 2, 100),
  'AOA': const Currency._private('AOA', 'Kwanza', 973, 2, 100),
  'ARS': const Currency._private('ARS', 'Argentine Peso', 32, 2, 100),
  'AUD': const Currency._private('AUD', 'Australian Dollar', 36, 2, 100),
  'AWG': const Currency._private('AWG', 'Aruban Florin', 533, 2, 100),
  'AZN': const Currency._private('AZN', 'Azerbaijanian Manat', 944, 2, 100),
  'BAM': const Currency._private('BAM', 'Convertible Mark', 977, 2, 100),
  'BBD': const Currency._private('BBD', 'Barbados Dollar', 52, 2, 100),
  'BDT': const Currency._private('BDT', 'Taka', 50, 2, 100),
  'BGN': const Currency._private('BGN', 'Bulgarian Lev', 975, 2, 100),
  'BHD': const Currency._private('BHD', 'Bahraini Dinar', 48, 3, 1000),
  'BIF': const Currency._private('BIF', 'Burundi Franc', 108, 0, 100),
  'BMD': const Currency._private('BMD', 'Bermudian Dollar', 60, 2, 100),
  'BND': const Currency._private('BND', 'Brunei Dollar', 96, 2, 100),
  'BOB': const Currency._private('BOB', 'Boliviano', 68, 2, 100),
  'BOV': const Currency._private('BOV', 'Mvdol', 984, 2, 100),
  'BRL': const Currency._private('BRL', 'Brazilian Real', 986, 2, 100),
  'BSD': const Currency._private('BSD', 'Bahamian Dollar', 44, 2, 100),
  'BTN': const Currency._private('BTN', 'Ngultrum', 64, 2, 100),
  'BWP': const Currency._private('BWP', 'Pula', 72, 2, 100),
  'BYR': const Currency._private('BYR', 'Belarussian Ruble', 974, 0, 100),
  'BZD': const Currency._private('BZD', 'Belize Dollar', 84, 2, 100),
  'CAD': const Currency._private('CAD', 'Canadian Dollar', 124, 2, 100),
  'CDF': const Currency._private('CDF', 'Congolese Franc', 976, 2, 100),
  'CHE': const Currency._private('CHE', 'WIR Euro', 947, 2, 100),
  'CHF': const Currency._private('CHF', 'Swiss Franc', 756, 2, 100),
  'CHW': const Currency._private('CHW', 'WIR Franc', 948, 2, 100),
  'CLF': const Currency._private('CLF', 'Unidades de fomento', 990, 0, 100),
  'CLP': const Currency._private('CLP', 'Chilean Peso', 152, 0, 100),
  'CNY': const Currency._private('CNY', 'Yuan Renminbi', 156, 2, 100),
  'COP': const Currency._private('COP', 'Colombian Peso', 170, 2, 100),
  'COU': const Currency._private('COU', 'Unidad de Valor Real', 970, 2, 100),
  'CRC': const Currency._private('CRC', 'Costa Rican Colon', 188, 2, 100),
  'CUC': const Currency._private('CUC', 'Peso Convertible', 931, 2, 100),
  'CUP': const Currency._private('CUP', 'Cuban Peso', 192, 2, 100),
  'CVE': const Currency._private('CVE', 'Cape Verde Escudo', 132, 2, 100),
  'CZK': const Currency._private('CZK', 'Czech Koruna', 203, 2, 100),
  'DJF': const Currency._private('DJF', 'Djibouti Franc', 262, 0, 100),
  'DKK': const Currency._private('DKK', 'Danish Krone', 208, 2, 100),
  'DOP': const Currency._private('DOP', 'Dominican Peso', 214, 2, 100),
  'DZD': const Currency._private('DZD', 'Algerian Dinar', 12, 2, 100),
  'EGP': const Currency._private('EGP', 'Egyptian Pound', 818, 2, 100),
  'ERN': const Currency._private('ERN', 'Nakfa', 232, 2, 100),
  'ETB': const Currency._private('ETB', 'Ethiopian Birr', 230, 2, 100),
  'EUR': const Currency._private('EUR', 'Euro', 978, 2, 100),
  'FJD': const Currency._private('FJD', 'Fiji Dollar', 242, 2, 100),
  'FKP': const Currency._private('FKP', 'Falkland Islands Pound', 238, 2, 100),
  'GBP': const Currency._private('GBP', 'Pound Sterling', 826, 2, 100),
  'GEL': const Currency._private('GEL', 'Lari', 981, 2, 100),
  'GHS': const Currency._private('GHS', 'Ghana Cedi', 936, 2, 100),
  'GIP': const Currency._private('GIP', 'Gibraltar Pound', 292, 2, 100),
  'GMD': const Currency._private('GMD', 'Dalasi', 270, 2, 100),
  'GNF': const Currency._private('GNF', 'Guinea Franc', 324, 0, 100),
  'GTQ': const Currency._private('GTQ', 'Quetzal', 320, 2, 100),
  'GYD': const Currency._private('GYD', 'Guyana Dollar', 328, 2, 100),
  'HKD': const Currency._private('HKD', 'Hong Kong Dollar', 344, 2, 100),
  'HNL': const Currency._private('HNL', 'Lempira', 340, 2, 100),
  'HRK': const Currency._private('HRK', 'Croatian Kuna', 191, 2, 100),
  'HTG': const Currency._private('HTG', 'Gourde', 332, 2, 100),
  'HUF': const Currency._private('HUF', 'Forint', 348, 2, 100),
  'IDR': const Currency._private('IDR', 'Rupiah', 360, 2, 100),
  'ILS': const Currency._private('ILS', 'New Israeli Sheqel', 376, 2, 100),
  'INR': const Currency._private('INR', 'Indian Rupee', 356, 2, 100),
  'IQD': const Currency._private('IQD', 'Iraqi Dinar', 368, 3, 1000),
  'IRR': const Currency._private('IRR', 'Iranian Rial', 364, 2, 100),
  'ISK': const Currency._private('ISK', 'Iceland Krona', 352, 0, 100),
  'JMD': const Currency._private('JMD', 'Jamaican Dollar', 388, 2, 100),
  'JOD': const Currency._private('JOD', 'Jordanian Dinar', 400, 3, 100),
  'JPY': const Currency._private('JPY', 'Yen', 392, 0, 1),
  'KES': const Currency._private('KES', 'Kenyan Shilling', 404, 2, 100),
  'KGS': const Currency._private('KGS', 'Som', 417, 2, 100),
  'KHR': const Currency._private('KHR', 'Riel', 116, 2, 100),
  'KMF': const Currency._private('KMF', 'Comoro Franc', 174, 0, 100),
  'KPW': const Currency._private('KPW', 'North Korean Won', 408, 2, 100),
  'KRW': const Currency._private('KRW', 'Won', 410, 0, 100),
  'KWD': const Currency._private('KWD', 'Kuwaiti Dinar', 414, 3, 1000),
  'KYD': const Currency._private('KYD', 'Cayman Islands Dollar', 136, 2, 100),
  'KZT': const Currency._private('KZT', 'Tenge', 398, 2, 100),
  'LAK': const Currency._private('LAK', 'Kip', 418, 2, 100),
  'LBP': const Currency._private('LBP', 'Lebanese Pound', 422, 2, 100),
  'LKR': const Currency._private('LKR', 'Sri Lanka Rupee', 144, 2, 100),
  'LRD': const Currency._private('LRD', 'Liberian Dollar', 430, 2, 100),
  'LSL': const Currency._private('LSL', 'Loti', 426, 2, 100),
  'LTL': const Currency._private('LTL', 'Lithuanian Litas', 440, 2, 100),
  'LVL': const Currency._private('LVL', 'Latvian Lats', 428, 2, 100),
  'LYD': const Currency._private('LYD', 'Libyan Dinar', 434, 3, 1000),
  'MAD': const Currency._private('MAD', 'Moroccan Dirham', 504, 2, 100),
  'MDL': const Currency._private('MDL', 'Moldovan Leu', 498, 2, 100),
  'MGA': const Currency._private('MGA', 'Malagasy Ariary', 969, 2, 5),
  'MKD': const Currency._private('MKD', 'Denar', 807, 2, 100),
  'MMK': const Currency._private('MMK', 'Kyat', 104, 2, 100),
  'MNT': const Currency._private('MNT', 'Tugrik', 496, 2, 100),
  'MOP': const Currency._private('MOP', 'Pataca', 446, 2, 100),
  'MRO': const Currency._private('MRO', 'Ouguiya', 478, 2, 5),
  'MUR': const Currency._private('MUR', 'Mauritius Rupee', 480, 2, 100),
  'MVR': const Currency._private('MVR', 'Rufiyaa', 462, 2, 100),
  'MWK': const Currency._private('MWK', 'Kwacha', 454, 2, 100),
  'MXN': const Currency._private('MXN', 'Mexican Peso', 484, 2, 100),
  'MXV': const Currency._private('MXV', 'Mexican Unidad de Inversion (UDI)', 979, 2, 100),
  'MYR': const Currency._private('MYR', 'Malaysian Ringgit', 458, 2, 100),
  'MZN': const Currency._private('MZN', 'Mozambique Metical', 943, 2, 100),
  'NAD': const Currency._private('NAD', 'Namibia Dollar', 516, 2, 100),
  'NGN': const Currency._private('NGN', 'Naira', 566, 2, 100),
  'NIO': const Currency._private('NIO', 'Cordoba Oro', 558, 2, 100),
  'NOK': const Currency._private('NOK', 'Norwegian Krone', 578, 2, 100),
  'NPR': const Currency._private('NPR', 'Nepalese Rupee', 524, 2, 100),
  'NZD': const Currency._private('NZD', 'New Zealand Dollar', 554, 2, 100),
  'OMR': const Currency._private('OMR', 'Rial Omani', 512, 3, 1000),
  'PAB': const Currency._private('PAB', 'Balboa', 590, 2, 100),
  'PEN': const Currency._private('PEN', 'Nuevo Sol', 604, 2, 100),
  'PGK': const Currency._private('PGK', 'Kina', 598, 2, 100),
  'PHP': const Currency._private('PHP', 'Philippine Peso', 608, 2, 100),
  'PKR': const Currency._private('PKR', 'Pakistan Rupee', 586, 2, 100),
  'PLN': const Currency._private('PLN', 'Zloty', 985, 2, 100),
  'PYG': const Currency._private('PYG', 'Guarani', 600, 0, 100),
  'QAR': const Currency._private('QAR', 'Qatari Rial', 634, 2, 100),
  'RON': const Currency._private('RON', 'New Romanian Leu', 946, 2, 100),
  'RSD': const Currency._private('RSD', 'Serbian Dinar', 941, 2, 100),
  'RUB': const Currency._private('RUB', 'Russian Ruble', 643, 2, 100),
  'RWF': const Currency._private('RWF', 'Rwanda Franc', 646, 0, 100),
  'SAR': const Currency._private('SAR', 'Saudi Riyal', 682, 2, 100),
  'SBD': const Currency._private('SBD', 'Solomon Islands Dollar', 90, 2, 100),
  'SCR': const Currency._private('SCR', 'Seychelles Rupee', 690, 2, 100),
  'SDG': const Currency._private('SDG', 'Sudanese Pound', 938, 2, 100),
  'SEK': const Currency._private('SEK', 'Swedish Krona', 752, 2, 100),
  'SGD': const Currency._private('SGD', 'Singapore Dollar', 702, 2, 100),
  'SHP': const Currency._private('SHP', 'Saint Helena Pound', 654, 2, 100),
  'SLL': const Currency._private('SLL', 'Leone', 694, 2, 100),
  'SOS': const Currency._private('SOS', 'Somali Shilling', 706, 2, 100),
  'SRD': const Currency._private('SRD', 'Surinam Dollar', 968, 2, 100),
  'SSP': const Currency._private('SSP', 'South Sudanese Pound', 728, 2, 100),
  'STD': const Currency._private('STD', 'Dobra', 678, 2, 100),
  'SVC': const Currency._private('SVC', 'El Salvador Colon', 222, 2, 100),
  'SYP': const Currency._private('SYP', 'Syrian Pound', 760, 2, 100),
  'SZL': const Currency._private('SZL', 'Lilangeni', 748, 2, 100),
  'THB': const Currency._private('THB', 'Baht', 764, 2, 100),
  'TJS': const Currency._private('TJS', 'Somoni', 972, 2, 100),
  'TMT': const Currency._private('TMT', 'Turkmenistan New Manat', 934, 2, 100),
  'TND': const Currency._private('TND', 'Tunisian Dinar', 788, 3, 1000),
  'TOP': const Currency._private('TOP', 'Pa’anga', 776, 2, 100),
  'TRY': const Currency._private('TRY', 'Turkish Lira', 949, 2, 100),
  'TTD': const Currency._private('TTD', 'Trinidad and Tobago Dollar', 780, 2, 100),
  'TWD': const Currency._private('TWD', 'New Taiwan Dollar', 901, 2, 100),
  'TZS': const Currency._private('TZS', 'Tanzanian Shilling', 834, 2, 100),
  'UAH': const Currency._private('UAH', 'Hryvnia', 980, 2, 100),
  'UGX': const Currency._private('UGX', 'Uganda Shilling', 800, 0, 100),
  'USD': const Currency._private('USD', 'US Dollar', 840, 2, 100),
  'USN': const Currency._private('USN', 'US Dollar (Next day)', 997, 2, 100),
  'USS': const Currency._private('USS', 'US Dollar (Same day)', 998, 2, 100),
  'UYI': const Currency._private('UYI', 'Uruguay Peso en Unidades Indexadas (URUIURUI)', 940, 0, 100),
  'UYU': const Currency._private('UYU', 'Peso Uruguayo', 858, 2, 100),
  'UZS': const Currency._private('UZS', 'Uzbekistan Sum', 860, 2, 100),
  'VEF': const Currency._private('VEF', 'Bolivar', 937, 2, 100),
  'VND': const Currency._private('VND', 'Dong', 704, 0, 10),
  'VUV': const Currency._private('VUV', 'Vatu', 548, 0, 1),
  'WST': const Currency._private('WST', 'Tala', 882, 2, 100),
  'XAF': const Currency._private('XAF', 'CFA Franc BEAC', 950, 0, 100),
  'XAG': const Currency._private('XAG', 'Silver', 961, 0, 100),
  'XAU': const Currency._private('XAU', 'Gold', 959, 0, 100),
  'XBA': const Currency._private('XBA', 'Bond Markets Unit European Composite Unit (EURCO)', 955, 0, 100),
  'XBB': const Currency._private('XBB', 'Bond Markets Unit European Monetary Unit (E.M.U.-6)', 956, 0, 100),
  'XBC': const Currency._private('XBC', 'Bond Markets Unit European Unit of Account 9 (E.U.A.-9)', 957, 0, 100),
  'XBD': const Currency._private('XBD', 'Bond Markets Unit European Unit of Account 17 (E.U.A.-17)', 958, 0, 100),
  'XCD': const Currency._private('XCD', 'East Caribbean Dollar', 951, 2, 100),
  'XDR': const Currency._private('XDR', 'SDR (Special Drawing Right)', 960, 0, 100),
  'XFU': const Currency._private('XFU', 'UIC-Franc', 958, 0, 100),
  'XOF': const Currency._private('XOF', 'CFA Franc BCEAO', 952, 0, 100),
  'XPD': const Currency._private('XPD', 'Palladium', 964, 0, 100),
  'XPF': const Currency._private('XPF', 'CFP Franc', 953, 0, 100),
  'XPT': const Currency._private('XPT', 'Platinum', 962, 0, 100),
  'XSU': const Currency._private('XSU', 'Sucre', 994, 0, 100),
  'XTS': const Currency._private('XTS', 'Codes specifically reserved for testing purposes', 963, 0, 100),
  'XUA': const Currency._private('XUA', 'ADB Unit of Account', 965, 0, 100),
  'XXX': const Currency._private('XXX', 'The codes assigned for transactions where no currency is involved', 999, 0, 100),
  'YER': const Currency._private('YER', 'Yemeni Rial', 886, 2, 100),
  'ZAR': const Currency._private('ZAR', 'Rand', 710, 2, 100),
  'ZMW': const Currency._private('ZMW', 'Zambian Kwacha', 967, 2, 100),
  'ZWL': const Currency._private('ZWL', 'Zimbabwe Dollar', 932, 2, 100),
};