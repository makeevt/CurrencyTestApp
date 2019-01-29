//
//  CurrencyTestAppTests.swift
//  CurrencyTestAppTests
//
//  Created by makeev on 25.01.2019.
//

import XCTest
@testable import CurrencyTestApp

var provider: WebMobileAPIProvider!

class CurrencyTestAppTests: XCTestCase {

    override func setUp() {
        super.setUp()
        provider = WebMobileAPIProvider(authorizationType: .unauthorized)
    }

    override func tearDown() {
        provider = nil
        super.tearDown()
    }

    func testDefaultCurrencyRequest() {
        let promise = expectation(description: "Correct currencies")
        
        provider.request(.getCurrency(base: CurrencyRateViewModel.CurrencyType.eur.shortName), successHandler: {(result: NetworkCurrency) in
            guard !result.rates.isEmpty else {
                XCTFail("Rates object is empty")
                return
            }
            for rate in result.rates {
                if CurrencyRateViewModel.CurrencyType(rawValue: rate.key) == nil {
                    XCTFail("Currency types does not include obtained key")
                }
            }
            promise.fulfill()
        }, errorHandler: {error in
            XCTFail(error.localizedDescription)
        })
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
