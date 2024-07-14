//
//  DetailViewController..swift
//
//
//  Created by Xcode on 10.06.2024.
//


import UIKit

final class DetailViewController: UIViewController {
    private let customView = DetailView()
    var presenter: DetailPresenter?

    init(model: RecipeDetailModel) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = DetailPresenter(view: customView, model: model)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
//        navigationBarCustom()
    }
}





//final class DetailViewController: UIViewController {
//
//    private let customView = DetailView()
//
//    override func loadView() {
//        self.view = customView
//        navigationBarCustom()
//
//
//extension DetailViewController {
//
//    func navigationBarCustom() {
//        navigationItem.title = "Recipe detail".uppercased()
//        let backButton = UIButton()
//        backButton.setImage(UIImage(named: "arrowBackNavigation"), for: UIControl.State())
//        backButton.addTarget(self, action: #selector(actionBackNavigationButton), for: UIControl.Event.touchUpInside)
//        let leftBarButtonItem = UIBarButtonItem(customView: backButton)
//        navigationItem.leftBarButtonItem = leftBarButtonItem
//    }
//    @objc func actionBackNavigationButton() {
//        navigationController?.popViewController(animated: true)
//    }
//}
//
//
//
//@available(iOS 17.0, *)
//#Preview {
//    DetailViewController()
//}
