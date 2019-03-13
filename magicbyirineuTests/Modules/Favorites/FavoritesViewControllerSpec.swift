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

        context("when it is initialized with empty collection view") {
            it("should match view with snapshot", closure: {
                sut.set(status: .empty)
                expect(sut) == snapshot()
            })
        }

        context("when it is initialized with at least one favorite") {
            it("should match view with snapshot", closure: {
                sut.set(status: .normal)
                expect(sut) == snapshot()
            })
        }
    }
}
