import UIKit
import FirebaseAuth
@MainActor
class SignUpVC: UIViewController {
   
    
    // MARK: Outlets
    @IBOutlet weak var EmailTextFiled: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var AgeTF: UITextField!
  //  @IBOutlet weak var WeightTF: UITextField!
  //  @IBOutlet weak var selectGender: UISegmentedControl!
  //  @IBOutlet weak var selectLifeStage: UISegmentedControl!
    
    private var activeTextField: UITextField?
    var selectedGender: String? = "Male"
    var selectedLifeStage: String? = "Young"
    let lifeStagesForMale: [String] = ["Young", "Old"]
    let lifeStagesForFemale: [String] = ["Young", "Old", "Pregnant"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
        configure()
      //  updateLifeStageOptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupTextField() {
        print("This is being called.")
        EmailTextFiled.delegate = self
        EmailTextFiled.keyboardType = .emailAddress
        EmailTextFiled.autocorrectionType = .no
        fullNameTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .newPassword
        Utility.addEyeIcon(passwordTextField)
        confirmPassword.delegate = self
        confirmPassword.keyboardType = .default
        confirmPassword.isSecureTextEntry = true
        confirmPassword.textContentType = .newPassword
       // WeightTF.delegate = self
      //  WeightTF.keyboardType = .decimalPad
        AgeTF.delegate = self
        AgeTF.keyboardType = .numberPad
    }
    
//    private func updateLifeStageOptions() {
//        if selectGender.selectedSegmentIndex == 0 {
//            selectLifeStage.removeAllSegments()
//            for (index, stage) in lifeStagesForMale.enumerated() {
//                selectLifeStage.insertSegment(withTitle: stage, at: index, animated: false)
//            }
//        } else {
//            selectLifeStage.removeAllSegments()
//            for (index, stage) in lifeStagesForFemale.enumerated() {
//                selectLifeStage.insertSegment(withTitle: stage, at: index, animated: false)
//            }
//        }
//        selectLifeStage.selectedSegmentIndex = 0
//    }
    
    private func navigateToVeryEmailVC() {
        let vc = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "VerifyEmailVC") as! VerifyEmailVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    @IBAction func didTapGenderSegmentChanged(_ sender: UISegmentedControl) {
//        updateLifeStageOptions()
//        let selectedIndex = sender.selectedSegmentIndex
//        switch selectedIndex {
//        case 0:
//            selectedGender = "Male"
//        case 1:
//            selectedGender = "Female"
//        default:
//            break
//        }
   // }
    
//    @IBAction func didTapLifeStageSegmentChanged(_ sender: UISegmentedControl) {
//        let selectedIndex = sender.selectedSegmentIndex
//        if selectedGender == "Male" {
//            selectedLifeStage = lifeStagesForMale[selectedIndex]
//        } else {
//            selectedLifeStage = lifeStagesForFemale[selectedIndex]
//        }
//    }
//    
    @IBAction func didTapsignUpButtonTapped(_ sender: UIButton)  {
        // Validate Full Name
        guard let name = fullNameTextField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else {
            Utility.showAlert(title: "Name Required", message: "Please enter your full name.", viewController: self)
            return
        }
        
        // Validate Email
        guard let email = EmailTextFiled.text?.trimmingCharacters(in: .whitespaces), !email.isEmpty, Utility.isValidEmail(email: email) else {
            Utility.showAlert(title: "Invalid Email", message: "Please enter a valid email address.", viewController: self)
            return
        }
        
        // Validate Password
        guard let password = passwordTextField.text, !password.isEmpty else {
            Utility.showAlert(title: "Password Required", message: "Please enter a password.", viewController: self)
            return
        }
        
        if !Utility.isPasswordValid(password: password) {
            Utility.showAlert(
                title: "Invalid Password",
                message: """
                    Your password must be:
                    - At least 8 characters long
                    - Contain uppercase and lowercase letters
                    - Include at least one number
                    - Include at least one special character
                    """,
                viewController: self
            )
            return
        }
        
        // Validate Confirm Password
        guard let confirmPassword = confirmPassword.text, !confirmPassword.isEmpty, password == confirmPassword else {
            Utility.showAlert(title: "Password Mismatch", message: "Passwords do not match.", viewController: self)
            return
        }
        
        // Validate Age
        guard let ageText = AgeTF.text, let age = Int(ageText), age >= 18 && age <= 100 else {
            Utility.showAlert(title: "Invalid Age", message: "Please enter an age between 18 and 100.", viewController: self)
            return
        }
        
        // Validate Weight
//        guard let weightText = WeightTF.text, let weight = Double(weightText), weight > 0 else {
//            Utility.showAlert(title: "Invalid Weight", message: "Please enter a valid weight greater than 0.", viewController: self)
//            return
//        }
        
        // Validate Gender and Life Stage
//        guard let gender = selectedGender, !gender.isEmpty else {
//            Utility.showAlert(title: "Gender Required", message: "Please select a gender.", viewController: self)
//            return
//        }
//        
//        guard let lifeStage = selectedLifeStage, !lifeStage.isEmpty else {
//            Utility.showAlert(title: "Life Stage Required", message: "Please select a life stage.", viewController: self)
//            return
//        }
//
        let newUser = UserDataModel(
            uid: "",
            userName: name,
            email: email,
            age: age,
           // weight: weight,
          //  gender: gender,
          //  lifeStage: lifeStage,
            profilePicURL: nil
        )

        // registerVM.registerUser(user: newUser, password: password, profileImage: nil)
         self.showHUD(progressLabel: "Registering user...")
         RegisterVM.shared.registerUser(user: newUser, password: password) { authResult   in
             self.dismissHUD(isAnimated: true)
             switch authResult {
             case .success(let user) :
                 print(user)
                 self.navigateToHome()
                 UserDefaults.standard.set(true, forKey: UserDefaultKeys.shared.hasCompletedOnboarding)
             case .failure(let error):
                 print(error.localizedDescription)
                 Utility.showAlert(title: "Registeration Failed", message: "\(error.localizedDescription)", viewController: self)
             }
         }
    }
    
    @IBAction func didTapalreadyHaveAccountBtn(_ sender: UIButton) {
        let loginVC = LoginVC.instantiate()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}

// MARK: - TextField Delegate Methods
extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}

extension SignUpVC {
    private func navigateToHome() {
        let vc = HomeVC.instantiate()
        navigationController?.pushViewController(vc, animated: true)
    }
}
    
// MARK: - ViewModel Setup
extension SignUpVC {
    func configure() {
        initViewModel()
        eventObserver()
    }
    
    func initViewModel() {
    }
    
    func eventObserver() {
        AuthViewModel.shared.eventHandler = { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .loading:
                LoaderManager.showLoader(on: self.view, message: "Creating Account...")
            case .stopLoading:
                LoaderManager.hideLoader(from: self.view)
            case .success:
                LoaderManager.showSuccess(on: self.view, message: "Sign Up Successful")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    // Move to HomeVC after success
                    self.navigateToVeryEmailVC()
                }
            case .error(let errorMessage):
                LoaderManager.showError(on: self.view, message: errorMessage)
            }
        }
    }
}
