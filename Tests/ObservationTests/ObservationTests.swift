import XCTest
@testable import Observation


final class ObservationTests: XCTestCase {
	
	var token: AnyToken?
	
	func testExample() {
		
		// instantiate objects
		let e = XCTestExpectation(description: "expected to call closure")
		let person = Person()
		
		// start observing
		token = person.when(.didRefresh) { (p) in
			e.fulfill()
		}
		
		// post event
		person.post(.didRefresh)
		
		// wait for observation token to execute its action
		wait(for: [e], timeout: 0.1)
		
		// clean up (not technically necessary in this case, but good practice)
		token = nil
	}

    private let iterationCount = 1000

    func testSpeed_PostOffice_CreateTokens() {
        let person = Person()

        self.measure {
            for _ in 1...iterationCount {
                _ = person.when(.didRefresh) { (p) in
                    print("Do thing")
                }
            }
        }
    }
	
	static var allTests = [
		("testExample", testExample),
	]
}
