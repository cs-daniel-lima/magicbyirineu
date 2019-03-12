import Nimble
import Nimble_Snapshots
import Quick

@testable import magicbyirineu

class FavoritesViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: FavoritesViewController!

        beforeEach {
            sut = FavoritesViewController(title: "Favorites")
            UIApplication.shared.keyWindow?.rootViewController = sut
        }

        context("when it is initialized") {
            it("should view match with snapshot") {
                expect(sut) == snapshot()
            }
        }
    }
}
