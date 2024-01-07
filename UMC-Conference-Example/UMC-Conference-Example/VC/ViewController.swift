//
//  ViewController.swift
//  UMC-Conference-Example
//
//  Created by Celan on 1/7/24.
//

import UIKit

final class ViewController: UIViewController {
  enum Section {
    case main
  }
  
  internal let networkManager = NetworkManager<FashionItem>()
  private var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Section, FashionItem>!
  private var fashionItems: [FashionItem] = []
  private var fashionItemFetchTask: Task<[FashionItem], Never>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemRed
    configCollectionView()
    fetchFashionItems()
    configDiffableDataSource()
    updateData()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    fashionItemFetchTask?.cancel()
    fashionItemFetchTask = nil
  }
  
  private func fetchFashionItems() {
    fashionItemFetchTask = Task {
      do {
        let result = try await networkManager.fetchItems()
        return result
        
      } catch {
        handleErrorsFromNetworkCall(error: error)
        return []
      }
    }
    
    Task {
      guard let fashionItemFetchTask else { return }
      self.fashionItems = await fashionItemFetchTask.value
      updateData()
    }
  }
  
  private func handleErrorsFromNetworkCall(error: any Error) {
    switch error as? NetworkError {
    case .invalidDataFormat:
      presentAlert(
        alertTitle: "데이터 형식 오류",
        message: "데이터 형식이 올바르지 않습니다! 데이터 형식을 확인해 주세요.",
        buttonTitle: "네"
      )
    case .invalidUrl:
      presentAlert(
        alertTitle: "URL 오류",
        message: "서버 URL이 올바르지 않습니다! URL 주소를 다시 확인해 주세요.",
        buttonTitle: "네"
      )
    case .networkError:
      presentAlert(
        alertTitle: "네트워크 오류",
        message: "네트워크 요청이 불안정합니다. 연결을 확인해 주세요",
        buttonTitle: "네"
      )
    case .none:
      return
    }
  }
  
  private func configCollectionView() {
    collectionView = UICollectionView(
      frame: view.bounds,
      collectionViewLayout: .createGridLayout(
        with: GridInfo(columns: 3),
        in: self.view
      )
    )
    
    view.addSubview(collectionView)
    collectionView.backgroundColor = .systemBackground
    collectionView.register(
      FashionItemCell.self,
      forCellWithReuseIdentifier: FashionItemCell.reuseId
    )
  }
  
  private func updateData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, FashionItem>()
    snapshot.appendSections([.main])
    snapshot.appendItems(self.fashionItems)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
  
  private func configDiffableDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, FashionItem>(
      collectionView: collectionView,
      cellProvider: { collectionView, indexPath, follower in
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: FashionItemCell.reuseId,
          for: indexPath
        ) as! FashionItemCell
        cell.set(with: self.fashionItems[indexPath.row])
        return cell
      }
    )
  }
  
  private func presentAlert(
    alertTitle: String,
    message: String,
    buttonTitle: String
  ) {
    Task { @MainActor in
      let alertVC = AlertVC(
        alertTitle: alertTitle,
        message: message,
        buttonTitle: buttonTitle
      )
      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve
      self.present(alertVC, animated: true)
    }
  }
}

