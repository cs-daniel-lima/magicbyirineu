import Nimble
import Nimble_Snapshots
import Quick

@testable import magicbyirineu

class MagicTabBarControllerSpec: QuickSpec {
    override func spec() {
        var sut: MagicTabBarMock!

        beforeEach {
            sut = MagicTabBarMock()
            _ = sut.view
        }

        context("when it is initialized") {
            it("setupTabBar should be called") {
                expect(sut.setupTabBarIsCalled).to(beTrue())
            }

            it("setupTabBarItem should be called twice") {
                expect(sut.totalCallsToSetupTabBarItem).to(equal(2))
            }

            it("first and second viewcontrooler should be defined") {
                expect(sut.viewControllers?.count).to(equal(2))
            }

            it("tabbar subview should match with snapshot") {
                expect(sut.tabBar) == snapshot()
            }
        }
    }
}
