//
//  ViewController.swift
//  GameWord
//
//  Created by Bitton, Nir on 20/11/2019.
//  Copyright © 2019 Bitton, Nir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var hintView: UIView!
    @IBOutlet weak var plusHintView: UIView!
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    // Mark: - Private

    private var selectedTags:[LetterCell] = []
    private var wordAsCharacters:[Character] = []
    private var currentLevelList:[String] = ["לביא"]
    private var levelSelectedData:[LevelSelectData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpCollectionViewGesture()
    }

    // MARK: - Private

    private func setUpViews() {
        hintView.cornerRadius(25)
        plusHintView.cornerRadius(25)
        levelView.cornerRadius(20)
    }

    private func setUpCollectionViewGesture() {
        let longPressGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        longPressGesture.minimumPressDuration = 0.01
        collectionView.addGestureRecognizer(longPressGesture)
    }

    @objc private func handleGesture(_ sender: UITapGestureRecognizer) {
        let state: UIGestureRecognizer.State = sender.state
        let location: CGPoint = sender.location(in: collectionView)
        switch state {
        case .changed:
            if let indexPath: NSIndexPath = collectionView.indexPathForItem(at: location) as NSIndexPath? {
                if let cell = self.collectionView.cellForItem(at: indexPath as IndexPath) as? LetterCell {
                    self.handleCellSelection(cell: cell)
                }
            }
        case .ended:
//            success()
            clearCells()
            
//            isSameTry = false
        default:
            break
        }
//        self.handleNumOfTries()
    }

    func handleCellSelection(cell:LetterCell) {
        if !selectedTags.contains(cell) {
            selectedTags.append(cell)
            cell.backgroundColor = UIColor.midPurple()
            cell.letter.textColor = UIColor.nOrangeColor()
            
//            selectedLetters.text = selectedLetters.text! + cell.letter.text!
        } else {
            if selectedTags.count > 1 {
                if cell.tag == selectedTags[selectedTags.endIndex-2].tag {
                    let lastCell = selectedTags[selectedTags.endIndex-1]
                    lastCell.backgroundColor = UIColor.lightPurple()
                    lastCell.letter.textColor = UIColor.darkPurple()
                    
//                    selectedLetters.text!.remove(at:selectedLetters.text!.index(before: selectedLetters.text!.endIndex))
                    selectedTags.remove(at: selectedTags.endIndex-1)
                }
            }
        }
    }

    func clearCells() {
        selectedTags.forEach {
            $0.backgroundColor = .lightPurple()
            $0.letter.textColor = .darkPurple()
        }

        selectedTags.removeAll()
//        selectedLetters.text = ""
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LetterCell", for: indexPath) as! LetterCell
        let word = currentLevelList.first ?? ""
        if wordAsCharacters.isEmpty {
            wordAsCharacters = Array(word)
        }
        
        let randomIndex = Int(arc4random_uniform(UInt32(wordAsCharacters.count)))
        let letter = wordAsCharacters.remove(at: randomIndex)
        cell.strText = letter.description
        cell.tag = indexPath.row
        
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard !(UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.size.height == 667) else {
            return CGSize(width: (self.view.frame.width / 2) - 25, height: (self.view.frame.width / 2) - 25)
        }

        return CGSize(width: 155.0, height: 155.0)
    }
}
