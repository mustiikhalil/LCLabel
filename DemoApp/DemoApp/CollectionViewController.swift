// Copyright © 2022 Mustafa Khalil, Inc.
// Licensed under the Apache License, Version 2.0 (the 'License');
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an 'AS IS' BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import LCLabel
import UIKit

final class CollectionViewController: UIViewController {

  var dataSource: UICollectionViewDiffableDataSource<Int, String>?
  var snapshot: NSDiffableDataSourceSnapshot<Int, String>?

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
          string: itemIdentifier,
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
    var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
    self.snapshot = snapshot
    snapshot.appendSections([1])
    snapshot.appendItems(
      (1...10000).map { "item: \($0) + UUID: \(UUID())" },
      toSection: 1)
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
    collectionView.register(
      CollectionCell.self,
      forCellWithReuseIdentifier: "id")
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
    label.isUserInteractionEnabled = true
    label.numberOfLines = 0
    return label
  }()
}
