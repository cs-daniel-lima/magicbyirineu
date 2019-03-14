import Nimble
import Nimble_Snapshots
import Quick

@testable import magicbyirineu

class FavoritesPresenterSpec: QuickSpec {
    override func spec() {
        var sut = FavoritesPresenterMock(router: FavoritesRouter(), interactor: FavoritesInteractor(), view: FavoritesViewController(title: "Favorites"))

        beforeEach {
            UIApplication.shared.keyWindow?.rootViewController = sut.view
        }

        context("when it is initialized") {
            it("should go through numberOfSections", closure: {
                self.tester().waitForAnimationsToFinish()
                expect(sut.wasNumberOfSectionCalled).to(beTrue())
            })
        }
    }
}
