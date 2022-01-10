//
//  CollectionViewController.swift
//  DemoApp
//
//  Created by Mustafa Khalil on 2022-01-10.
//

import LCLabel
import UIKit

class CollectionViewController: UIViewController {

  var dataSource: UICollectionViewDiffableDataSource<Int, Int>?
  var snapshot: NSDiffableDataSourceSnapshot<Int, Int>?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(
        equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(
        equalTo: view.bottomAnchor),
    ])
    dataSource = .init(
      collectionView: collectionView,
      cellProvider: { collectionView, indexPath, itemIdentifier in
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: "id",
          for: indexPath) as! CollectionCell
        cell.text = NSAttributedString(
          string: "item: \(itemIdentifier)+ \(indexPath) + UUID: \(UUID())",
          attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
          ])
        return cell
      })
    DispatchQueue.global(qos: .background).async {
      self.makeSnapshot()
    }
  }

  private func makeSnapshot(animatingDifferences: Bool = true) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
    self.snapshot = snapshot
    snapshot.appendSections([1])
    snapshot.appendItems((1...10000).map { $0 }, toSection: 1)
    DispatchQueue.main.async { [weak self] in
      self?.dataSource?.apply(
        snapshot,
        animatingDifferences: animatingDifferences)
    }
  }

  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: view.frame.width - 10, height: 30)
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: flowLayout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "id")
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .white
    return collectionView
  }()
}

private final class CollectionCell: UICollectionViewCell {

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor),
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      label.trailingAnchor.constraint(
        equalTo: trailingAnchor),
      label.bottomAnchor.constraint(
        equalTo: bottomAnchor),
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  var text: NSAttributedString? {
    didSet {
      label.attributedText = text
    }
  }

  private let label: LCLabel = {
    let label = LCLabel(frame: .zero)
    label.backgroundColor = .white
//    label.textAlignment = .top
    label.isUserInteractionEnabled = true
    label.numberOfLines = 0
    return label
  }()
}
