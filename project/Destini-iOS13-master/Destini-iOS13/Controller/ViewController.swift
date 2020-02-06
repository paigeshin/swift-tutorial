//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!

    var storyBrain = StoryBrain()
    var story: Story!

    override func viewDidLoad() {
        super.viewDidLoad()
        //일단 처음에 스토리를 가져와서 화면에 보여준다.
        story = storyBrain.getStory()
        updateUi(story)
    }

    @IBAction func choice1Clicked(_ sender: UIButton) {
        //일단 스토리 선택 값을 던지고 업데이트함
        updateUi(story)
        //다음
        story = storyBrain.nextChoice1Story(story)
    }

    @IBAction func choice2Clicked(_ sender: UIButton) {
        //일단 스토리 선택 값을 던지고 업데이트함
        updateUi(story)
        //다음
        story = storyBrain.nextChoice2Story(story)
    }

    func updateUi(_ story: Story) {
        storyLabel.text = story.title
        choice1Button.setTitle(story.choice1, for: .normal)
        choice2Button.setTitle(story.choice2, for: .normal)
    }


}

