//
//  PopOverContentController.swift
//  KkongNyangApp
//
//  Created by Doy Kim on 2022/06/16.
//

import UIKit
import SnapKit

class PopOverContentController: UIViewController {

    // MARK: - Properties
    let descriptionLabel: UILabel = {
        let l = UILabel()
        l.text = """
        육묘초대코드를 통해서 이미 꽁냥에 가입한 집사와
        함께 육묘할 수 있어요!
        가족 중 처음이시라면 코드 생성버튼을 눌러주세요.
        """
        l.textColor = .gray700
        l.font = UIFont.systemFont(ofSize: 14)
        
        return l
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupView()
        
    }
    
    // MARK: - Actions
    
    
    // MARK: - Layouts
    func setupView() {
        // Layout
        self.view.backgroundColor = .white
        self.view.addSubview(self.descriptionLabel)
        
        self.descriptionLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
}
