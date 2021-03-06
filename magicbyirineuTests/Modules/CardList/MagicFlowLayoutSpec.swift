import KIF
import Nimble
import Nimble_Snapshots
import Quick

@testable import magicbyirineu

class MagicFlowLayoutSpec: QuickSpec {
    override func spec() {
        var sut: MagicFlowLayoutMock!
        var viewController: CollectionViewControllerMock!

        beforeEach {
            sut = MagicFlowLayoutMock()

            let view = CollectionMock(mockLayout: sut)
            viewController = CollectionViewControllerMock(mockView: view)

            UIApplication.shared.keyWindow?.rootViewController = viewController

            _ = viewController.view
        }

        context("when it is initialized") {
            it("has minimumInteritemSpacing equal to 0") {
                expect(sut.minimumInteritemSpacing).to(equal(0))
            }

            it("has minimumInteritemSpacing equal to 0") {
                expect(sut.minimumLineSpacing).to(equal(16))
            }

            it("has section header should pin visible bounds") {
                expect(sut.sectionHeadersPinToVisibleBounds).to(beTrue())
            }

            it("has built layout properly") {
                self.tester().waitForAnimationsToFinish()
                expect(viewController) == snapshot()
            }
        }

        context("on CollectionViewFlowLayout lifecycle") {
            it("align method must be called") {
                self.tester().waitForAnimationsToFinish()
                expect(sut.alignWasCalled).to(beTrue())
            }

            it("layoutAttributesForItem method must be called") {
                self.tester().waitForAnimationsToFinish()
                expect(sut.layoutAttributesForItemWasCalled).to(beTrue())
            }

            it("layoutAttributesForElements method must be called") {
                self.tester().waitForAnimationsToFinish()
                expect(sut.layoutAttributesForElementsWasCalled).to(beTrue())
            }

            it("getCollectionWidth method must be called") {
                self.tester().waitForAnimationsToFinish()
                expect(sut.getCollectionWidthWasCalled).to(beTrue())
            }
        }
    }
}
