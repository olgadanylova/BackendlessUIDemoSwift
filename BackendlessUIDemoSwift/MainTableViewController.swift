
import UIKit
import BackendlessUI

class MainTableViewController: UITableViewController {
    
    private let APP_ID = ""
    private let API_KEY = ""

    private var functions = [String]()
    private let SIGN_UP = "Sign up"
    private let LOGIN = "Login"
    private let SOCIAL_LOGIN = "Social login"
    private let LOGOUT = "Logout"
    private let RESTORE_PASSWORD = "Restore password"
    
    // **************************************************
    
    private let CREATE_OBJECT = "Create object"
    private let UPDATE_OBJECT = "Update object"
    
    private let BASIC_FIND = "Find"
    private let ADVANCED_FIND = "Find + QB"
    private let FIND_FIRST = "Find first"
    private let ADVANCED_FIND_FIRST = "Find first + QB"
    private let FIND_LAST = "Find last"
    private let ADVANCED_FIND_LAST = "Find last + QB"
    private let FIND_BY_ID = "Find by id"
    private let ADVANCED_FIND_BY_ID = "Find by id + QB"
    private let RETRIEVE_RELATION = "Retrieve relation 1:1"
    private let RETRIEVE_RELATIONS = "Retrieve relations 1:N"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Backendless.sharedInstance().hostURL = "http://api.backendless.com"
        Backendless.sharedInstance().initApp(APP_ID, apiKey: API_KEY)
        setupFunctions()     
    }
    
    func setupFunctions() {
        functions.append(SIGN_UP)
        functions.append(LOGIN)
        functions.append(SOCIAL_LOGIN)
        functions.append(LOGOUT)
        functions.append(RESTORE_PASSWORD)
        
        // **************************************************
        
        functions.append(CREATE_OBJECT)
        functions.append(UPDATE_OBJECT)
        
        functions.append(BASIC_FIND)
        functions.append(ADVANCED_FIND)
        functions.append(FIND_FIRST)
        functions.append(ADVANCED_FIND_FIRST)
        functions.append(FIND_LAST)
        functions.append(ADVANCED_FIND_LAST)
        functions.append(FIND_BY_ID)
        functions.append(ADVANCED_FIND_BY_ID)
        functions.append(RETRIEVE_RELATION)
        functions.append(RETRIEVE_RELATIONS)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FunctionCell", for: indexPath)
        cell.textLabel?.text = functions[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let function = functions[indexPath.row]
        if function == SIGN_UP {
            let signUpVC = BackendlessSignUpViewController()
            navigationController?.pushViewController(signUpVC, animated: true)
        }
        else if function == LOGIN {
            let loginVC = BackendlessLoginViewController()
            navigationController?.pushViewController(loginVC, animated: true)
        }
        else if function == SOCIAL_LOGIN {
            let socialLoginVC = BackendlessSocialLoginViewController()
            socialLoginVC.configureWith(facebookLogin: true, googleLogin: true, twitterLogin: true)
            navigationController?.pushViewController(socialLoginVC, animated: true)
        }
        else if function == LOGOUT {
            let logoutVC = BackendlessLogoutViewController()
            navigationController?.pushViewController(logoutVC, animated: true)
        }
        else if function == RESTORE_PASSWORD {
            let restorePasswordVC = BackendlessRestorePasswordViewController()
            navigationController?.pushViewController(restorePasswordVC, animated: true)
        }

            // **************************************************

        else if function == CREATE_OBJECT {
            let createObjectVC = BackendlessAddObjectViewController()
            createObjectVC.configureWith(tableName: "TestTable", previousViewController: self)
            navigationController?.pushViewController(createObjectVC, animated: true)
        }
        else if function == UPDATE_OBJECT {
            Backendless.sharedInstance()?.data.ofTable("TestTable")?.findFirst({ object in
                let updateObjectVC = BackendlessObjectDetailsViewController()
                updateObjectVC.configureWith(tableName: "TestTable", object: object as! [String : Any], previousViewController: self)
                self.navigationController?.pushViewController(updateObjectVC, animated: true)
            }, error: { fault in
                AlertViewController.shared.showErrorAlert(fault!, nil, self)
            })
        }
        else if function == BASIC_FIND {
            let basicFindVC = BackendlessTableViewController()
            basicFindVC.configureWith(tableName: "TestTable")
            navigationController?.pushViewController(basicFindVC, animated: true)
        }
        else if function == ADVANCED_FIND {
            let queryBuilder = DataQueryBuilder()!
            queryBuilder.setSortBy(["stringVal"])
            let advancedFindVC = BackendlessTableViewController()
            advancedFindVC.configureWith(tableName: "TestTable", dataQueryBuilder: queryBuilder)
            navigationController?.pushViewController(advancedFindVC, animated: true)
        }
        else if function == FIND_FIRST {
            let findFirstVC = BackendlessTableViewController()
            findFirstVC.configureWith(tableName: "TestTable", findFirst: true)
            navigationController?.pushViewController(findFirstVC, animated: true)
        }
        else if function == ADVANCED_FIND_FIRST {
            let queryBuilder = DataQueryBuilder()!
            queryBuilder.setRelationsDepth(1)
            let advancedFindFirstVC = BackendlessTableViewController()
            advancedFindFirstVC.configureWith(tableName: "TestTable", findFirst: true, dataQueryBuilder: queryBuilder)
            navigationController?.pushViewController(advancedFindFirstVC, animated: true)
        }
        else if function == FIND_LAST {
            let findLastVC = BackendlessTableViewController()
            findLastVC.configureWith(tableName: "TestTable", findLast: true)
            navigationController?.pushViewController(findLastVC, animated: true)
        }
        else if function == ADVANCED_FIND_LAST {
            let queryBuilder = DataQueryBuilder()!
            queryBuilder.setRelationsDepth(1)
            let advancedFindLastVC = BackendlessTableViewController()
            advancedFindLastVC.configureWith(tableName: "TestTable", findLast: true, dataQueryBuilder: queryBuilder)
            navigationController?.pushViewController(advancedFindLastVC, animated: true)
        }
        else if function == FIND_BY_ID {
            let findByIdVC = BackendlessTableViewController()
            findByIdVC.configureWith(tableName: "TestTable", findById: "D09FB99F-2987-2127-FFAA-CA451C55DE00")
            navigationController?.pushViewController(findByIdVC, animated: true)
        }
        else if function == ADVANCED_FIND_BY_ID {
            let queryBuilder = DataQueryBuilder()!
            queryBuilder.setRelationsDepth(1)
            let advancedFindByIdVC = BackendlessTableViewController()
            advancedFindByIdVC.configureWith(tableName: "TestTable", findById: "D09FB99F-2987-2127-FFAA-CA451C55DE00", dataQueryBuilder: queryBuilder)
            navigationController?.pushViewController(advancedFindByIdVC, animated: true)
        }
        else if function == RETRIEVE_RELATION {
            Backendless.sharedInstance()?.data.ofTable("TestTable")?.findFirst({ object in
                let retrieveRelationVC = BackendlessRelationsViewController()
                retrieveRelationVC.configureWith(tableName: "TestTable", relationsColumnName: "user", parentObject: object as! [String : Any])
                self.navigationController?.pushViewController(retrieveRelationVC, animated: true)
            }, error: { fault in
                AlertViewController.shared.showErrorAlert(fault!, nil, self)
            })
        }
        else if function == RETRIEVE_RELATIONS {
            Backendless.sharedInstance()?.data.ofTable("TestTable")?.findFirst({ object in
                let retrieveRelationsVC = BackendlessRelationsViewController()
                retrieveRelationsVC.configureWith(tableName: "TestTable", relationsColumnName: "players", parentObject: object as! [String : Any])
                self.navigationController?.pushViewController(retrieveRelationsVC, animated: true)
            }, error: { fault in
                AlertViewController.shared.showErrorAlert(fault!, nil, self)
            })
        }
    }
}
