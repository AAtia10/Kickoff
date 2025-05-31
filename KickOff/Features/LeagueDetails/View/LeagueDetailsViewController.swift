
import UIKit


class LeagueDetailsViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = createLayout()
        
        collectionView.register(UINib(nibName: "LastMatchCell", bundle: nil), forCellWithReuseIdentifier: "LastMatchCell")
        
        collectionView.register(UINib(nibName: "UpcomingMatchCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingMatchCell")
        
        collectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: "TeamCell")
    }

    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0: return self.createLastMatchesSection()
            case 1: return self.createUpcomingMatchesSection()
            default: return self.createTeamsSection()
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 8
        case 1: return 5
        default: return 8
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastMatchCell", for: indexPath) as! LastMatchCell
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingMatchCell", for: indexPath) as! UpcomingMatchCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell
            return cell
        }

    }
    
    func createLastMatchesSection()-> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
      , heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75)
                                             , heightDimension: .fractionalHeight(0.18))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
      , subitems: [item])
          group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8
          , bottom: 8, trailing: 8)
          
      let section = NSCollectionLayoutSection(group: group)
          section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
          , bottom: 0, trailing: 0)
          section.orthogonalScrollingBehavior = .continuous
        
         return section
    }
    
    func createTeamsSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4)
                                               , heightDimension: .absolute(130))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8
                                                      , bottom: 8, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                        , bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func createUpcomingMatchesSection()->NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
            , heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
            , heightDimension: .absolute(110))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
            , subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8
            , bottom: 8, trailing: 8)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
            , bottom: 0, trailing: 0)
            return section
        }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

    }
    */

}
