//
//  SubjectActivityController.swift
//  GNNHS
//
//  Created by Noah Hanover on 11/3/15.
//  Copyright © 2015 Noah Hanover. All rights reserved.
//

import UIKit

class SubjectActivityController: BasisTableViewController, FUIAlertViewDelegate {
    enum subject_type: Int {
        case business = 0
        case esl = 1
        case english = 2
        case performing_arts = 3
        case foreign_lang = 4
        case guidance = 5
        case health = 6
        case math = 7
        case phys_ed = 8
        case science = 9
        case social_studies = 10
        case special_ed = 11
        case study_skills = 12
    }
    
    let EMAILSUFFIX = "@greatneck.k12.ny.us"
    let EMAILPREFIX = "mailto:"
    let TELPREFIX = "tel:"
    
    var phone_string: String
    var subject_activity: subject_type
    let guidance_teachers: OrderedDictionary<String, String> =
        [("Guidance Department", ""),
         ("Anton Berzins", "aberzins"),
         ("Michelle Boone", "mboone"),
         ("Jordana Cohen", "jcohen"),
         ("Kristen Cornicello", "kcornicello"),
         ("Rosemari Fransioli", "rfransioli"),
         ("Peter Hidasi", "phidasi"),
         ("Joan Lazaunik", "jlazaunik"),
         ("Randi Murphy", "rmurphy"),
         ("Micheal Neary", "mneary"),
         ("Corinne O'Connell", "coconnell"),
         ("Loretta Peskin", "lpeskin"),
         ("Amanda Reilly", "areilly"),
         ("Kim Semder", "ksemder")]
    
    let math_teachers: OrderedDictionary<String, String> =
        [("Math Department", ""),
         ("Vicky Anastasis", "vanastasis"),
         ("Joseph Bonvicino", "jbonvicino"),
         ("Colin Cubinski", "ccubinski"),
         ("Dawn Gagliano", "dgagliano"),
         ("Alissa Gomoka", "agomoka"),
         ("Elana Hagler", "ehagler"),
         ("Betty Krauz", "bkrauz"),
         ("Jaime Melendez", "jmelendez"),
         ("Jeffrey Sirotkin", "jsirotkin"),
         ("Nicholas Turkovich", "nturkovich"),
         ("Jennifer Virgilio", "jvirgilio"),
         ("Katie Williams", "kwilliams"),
         ("Greg Yager", "gyager"),
         ("John Zak", "jzak"),]
    
    let science_teachers: OrderedDictionary<String, String> =
        [("Science Department", ""),
         ("Soheila Afkham", "safkham"),
         ("Silvia Akerman", "sakerman"),
         ("Randy Appell", "rappell"),
         ("Chris Bambino", "cbambino"),
         ("Jessica Baylis", "jbaylis"),
         ("Chris Ceaser", "cceaser"),
         ("Tom Elkins", "telkins"),
         ("Linda Insler", "linsler"),
         ("Courtney Knacke", "cknacke"),
         ("Takoa Lawson", "tlawson"),
         ("Rebecca Leahy", "rleahy"),
         ("Maya Lerner", "mlerner"),
         ("Christine Maciuliatis", "cmaciuliatis"),
         ("Laura Pizaro", "lpizaro"),
         ("Paul Roach", "proach"),
         ("Fran Scannapieco", "fscannapieco"),
         ("Alan Schorn", "aschorn"),
         ("Jessica Schust", "jschust"),
         ("Anita Tseng", "atseng"),
         ("Dr. Marie Van Niewenhuizen", "mvannieuwenhuizen"),
         ("Jenna Veveakis", "jveveakis")]
    
    let english_teachers: OrderedDictionary<String, String> =
        [("English Department", ""),
         ("Edward Baluyut", "ebaluyut"),
         ("Cathlene Behan", "cbehan"),
         ("Matthew Blackstone", "mblackstone"),
         ("Eileen Davidson", "edavidson"),
         ("Jeffrey Gilden", "jgilden"),
         ("Kieran Griffin", "kgriffin"),
         ("Todd Henao", "thenao"),
         ("Scott Honig", "shonig"),
         ("Cailtlin Morrell", "cmorrell"),
         ("Jenny Post", "jpost"),
         ("Micheal Schad", "mschad"),
         ("Blaire Scheier", "bscheier"),
         ("Kathlyne Snyder", "ksnyder"),
         ("Loren Tunick", "ltunick"),
         ("Theresa Walter", "twalter")]
    
    let social_studies_teachers: OrderedDictionary<String, String> =
        [("Social Studies Department", ""),
         ("Susan Babkes", "sbabkes"),
         ("Paul Becker", "pbecker"),
         ("Gary Cohen", "gcohen"),
         ("Gillian Disney", "gdisney"),
         ("Josh Fialkow", "jfialkow"),
         ("Samatha Gallagher", "sgallagher"),
         ("Nicole Jacoberger", "njacoberger"),
         ("Casie Ludemann", "cludemann"),
         ("Glenn Maguire", "gmaguire"),
         ("Patricia McMahon", "pmcmahon"),
         ("Pam Ostrover", "postrover"),
         ("Eric Ragot", "eragot"),
         ("Laura Talamo", "ltalamo")]
    
    let foreign_lang_teachers: OrderedDictionary<String, String> =
        [("Foreign Language Department", ""),
         ("Joanna Asvestas", "jasvestas"),
         ("Madalyn DeLuccia", "mdeluccia"),
         ("Caitlin Gorta", "cgorta"),
         ("Israel Henriquez", "ihenriquez"),
         ("Chani Ivry", "civry"),
         ("Bessie Karanikolas", "bkaranikolas"),
         ("Lilian Krowne", "lkrowne"),
         ("Julia Lombardo", "jlombardo"),
         ("Johanne Lynch", "jlynch"),
         ("Kathy McAleer", "kmcaleer"),
         ("Christopher Pipala", "cpipala"),
         ("Dennis Villacorta", "dvillacorta")]
    
    let study_skills_teachers: OrderedDictionary<String, String> =
        [("Study Skills Department", ""),
         ("Silvia Ackerman", "sackerman"),
         ("Jean Marie Cromwell", "jcromwell"),
         ("Jodi Kahn", "jkahn"),
         ("Linda Litvack", "llitvack"),
         ("Lauren Loschiavo", "lloschiavo"),
         ("Susanne Marcus", "smarcus"),
         ("Libra Patrice", "lpatrice")]
    
    let business_teachers: OrderedDictionary<String, String> =
        [("Business Department", ""),
         ("Cara Burger", "cburger"),
         ("Richard Marchese", "rmarchese"),
         ("Sharon Miller", "smiller"),
         ("Paul Rodriguez", "prodriquez"),
         ("Kevin Spellman", "kspellman")]
    
    let esl_teachers: OrderedDictionary<String, String> =
        [("ESL Department", ""),
         ("Susanne Marcus", "smarcus")]
    
    let performing_arts_teachers: OrderedDictionary<String, String> =
        [("Performing Arts Department", ""),
         ("Jon Gellert", "jgellert"),
         ("Joseph Giacalone", "jgiacalone"),
         ("Christine Eisenhauer Hakanjin", "chakanjin"),
         ("Emily Man", "eman"),
         ("Janine Robinson", "jrobinson"),
         ("Joe Rutkowski", "jrutkowski"),
         ("Neil Saggerson", "nsaggerson")]
    
    let special_ed_teachers: OrderedDictionary<String, String> =
        [("Special Ed. Department", ""),
         ("Barbarsa Besso", "bbesso"),
         ("Keri Brucato", "kbrucato"),
         ("Micheal Calderaro", "mcalderaro"),
         ("Katie Duggan", "kduggan"),
         ("Maria Fiore", "mfiore"),
         ("Susan Giampetruzzi", "sgiampetruzzi"),
         ("Lindsay Haskel", "lhaskel"),
         ("Eileen Hirsch", "ehirsch"),
         ("James Kinder", "jkinder"),
         ("Donna Kramer", "dkramer"),
         ("Mike Lewis", "mlewis"),
         ("Merryl Mandler", "mmandler"),
         ("Tom Mangan", "tmangan"),
         ("Jennifer Nastri", "jnastri"),
         ("Amy Oleksiej", "aoleksiej"),
         ("Jamie Reyna", "jreyna"),
         ("Gail Schwarts", "gschwarts"),
         ("Blair Silver", "bsilver"),
         ("Jessica Skemer", "jskemer"),
         ("Joan Varghese", "jvargese"),
         ("Danielle Verserose", "dverserose")]
    
    let health_teachers: OrderedDictionary<String, String> =
        [("Health Department", ""),
         ("Kathleen Carpenter", "kcarpenter"),
         ("Lauren Mock", "lmock")]
    
    let phys_ed_teachers: OrderedDictionary<String, String> =
        [("Physical Ed. Department", ""),
         ("Justin Cisario", "jcisario"),
         ("Erik Connolly", "econnolly"),
         ("Eamonn Flood", "eflood"),
         ("Matt Lemanczyk", "mlemanczyk"),
         ("Jane Maher", "jmaher"),
         ("Marisol Mahler", "mmahler"),]
    
    init (subject: subject_type) {
        self.subject_activity = subject
        phone_string = ""
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.white
        self.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0, right: 0.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        var title_navigation: String
        
        switch subject_activity {
        case subject_type.business:
            title_navigation = "Business"
            break
        case subject_type.esl:
            title_navigation = "ESL"
            break
        case subject_type.english:
            title_navigation = "English"
            break
        case subject_type.performing_arts:
            title_navigation = "Fine & Performing Arts"
            break
        case subject_type.foreign_lang:
            title_navigation = "Foreign Language"
            break
        case subject_type.guidance:
            title_navigation = "Guidance"
            break
        case subject_type.health:
            title_navigation = "Health"
            break
        case subject_type.math:
            title_navigation = "Math"
            break
        case subject_type.phys_ed:
            title_navigation = "Physical Education"
            break
        case subject_type.science:
            title_navigation = "Science"
            break
        case subject_type.social_studies:
            title_navigation = "Social Studies"
            break
        case subject_type.special_ed:
            title_navigation = "Special Education"
            break
        case subject_type.study_skills:
            title_navigation = "Study Skills"
            break
        }
        
        self.navigationController?.navigationBar.topItem!.title = title_navigation
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch subject_activity {
        case subject_type.business:
            return business_teachers.count
        case subject_type.esl:
            return esl_teachers.count
        case subject_type.english:
            return english_teachers.count
        case subject_type.performing_arts:
            return performing_arts_teachers.count
        case subject_type.foreign_lang:
            return foreign_lang_teachers.count
        case subject_type.guidance:
            return guidance_teachers.count
        case subject_type.health:
            return health_teachers.count
        case subject_type.math:
            return math_teachers.count
        case subject_type.phys_ed:
            return phys_ed_teachers.count
        case subject_type.science:
            return science_teachers.count
        case subject_type.social_studies:
            return social_studies_teachers.count
        case subject_type.special_ed:
            return special_ed_teachers.count
        case subject_type.study_skills:
            return study_skills_teachers.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch subject_activity {
        case subject_type.guidance:
            cell.textLabel?.text = guidance_teachers.orderedKeys[(indexPath as NSIndexPath).row]
            break
        case subject_type.math:
            cell.textLabel?.text = math_teachers.orderedKeys[(indexPath as NSIndexPath).row]
            break
        case subject_type.science:
            cell.textLabel?.text = science_teachers.orderedKeys[(indexPath as NSIndexPath).row]
            break
        case subject_type.english:
            cell.textLabel?.text = english_teachers.orderedKeys[(indexPath as NSIndexPath).row]
            break
        case subject_type.social_studies:
            cell.textLabel?.text = social_studies_teachers.orderedKeys[(indexPath as NSIndexPath).row]
            break
        case subject_type.foreign_lang:
            cell.textLabel?.text = foreign_lang_teachers.orderedKeys[(indexPath as NSIndexPath).row]
            break
        case subject_type.study_skills:
            cell.textLabel?.text = study_skills_teachers.orderedKeys[(indexPath as NSIndexPath).row]
            break
        case subject_type.business:
            cell.textLabel?.text = business_teachers.orderedKeys[(indexPath as NSIndexPath).row]
            break
        case subject_type.esl:
            cell.textLabel?.text = esl_teachers.orderedKeys[(indexPath as NSIndexPath).row]
            break
        case subject_type.performing_arts:
            cell.textLabel?.text = performing_arts_teachers.orderedKeys[(indexPath as NSIndexPath).row]
            break
        case subject_type.special_ed:
            cell.textLabel?.text = special_ed_teachers.orderedKeys[(indexPath as NSIndexPath).row]
            break
        case subject_type.health:
            cell.textLabel?.text = health_teachers.orderedKeys[(indexPath as NSIndexPath).row]
            break
        case subject_type.phys_ed:
            cell.textLabel?.text = phys_ed_teachers.orderedKeys[(indexPath as NSIndexPath).row]
            break
        }
        
        cell = setCellBackgroundText(cell)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var main_string_next = String()
        
        if ((indexPath as NSIndexPath).row == 0) {
            
            
            switch subject_activity {
            case subject_type.guidance:
                main_string_next = "Room: 242 and 242A\n\nPhone: (516) 441-4720"
                phone_string = "(516)441-4720"
                break
            case subject_type.math:
                main_string_next = "Room: 122\n\nPhone: (516) 441-4750"
                phone_string = "(516)441-4750"
                break
            case subject_type.science:
                main_string_next = "Room: 213\n\nPhone: (516) 441-4754"
                phone_string = "(516)441-4754"
                break
            case subject_type.english:
                main_string_next = "Room: 109\n\nPhone: (516) 441-4744"
                phone_string = "(516)441-4744"
                break
            case subject_type.social_studies:
                main_string_next = "Room: 234\n\nPhone: N/A"
                break
            case subject_type.foreign_lang:
                main_string_next = "Room: 227\n\nPhone: (516) 441-4748"
                phone_string = "(516)441-4748"
                break
            case subject_type.study_skills:
                main_string_next = "Room: 214\n\nPhone: N/A"
                break
            case subject_type.business:
                main_string_next = "Room: 206\n\nPhone: (516) 441-4741"
                phone_string = "(516)441-4741"
                break
            case subject_type.esl:
                main_string_next = "Room: N/A\n\nPhone: (516) 441-4745"
                phone_string = "(516)441-4745"
                break
            case subject_type.performing_arts:
                main_string_next = "Room: N/A\n\nPhone: N/A"
                break
            case subject_type.special_ed:
                main_string_next = "Room: N/A\n\nPhone: N/A"
                break
            case subject_type.health:
                main_string_next = "Room: 130\n\nPhone: (516) 441-4747"
                phone_string = "(516)441-4747"
                break
            case subject_type.phys_ed:
                main_string_next = "Room: Across from Room 1\n\nPhone: N/A"
                break
            }
            var has_phone: Bool
            if (phone_string != "") {
                has_phone = true
            } else {
                has_phone = false
            }
            
            let alertView = FUIAlertView()
            alertView.title = (self.navigationController?.navigationBar.topItem!.title)! + " Department"
            alertView.message = main_string_next
            alertView.addButton(withTitle: "Cancel")
            
            if (has_phone) {
                alertView.addButton(withTitle: "Call Department")
            }
            
            alertView.delegate = self
            alertView.titleLabel!.textColor = UIColor(red: 0.09, green: 0.20, blue: 0.42, alpha: 1.0)
            alertView.titleLabel!.font = UIFont(name: "OpenSans-Bold", size: 16)
            alertView.messageLabel!.textColor = UIColor(red: 0.09, green: 0.20, blue: 0.42, alpha: 1.0)
            alertView.messageLabel!.font = UIFont(name: "OpenSans", size: 14)
            alertView.backgroundOverlay!.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 0.5)
            alertView.alertContainer!.backgroundColor = UIColor(red: 0.96, green: 0.62, blue: 0.38, alpha: 1.0)
            alertView.defaultButtonColor = UIColor(red: 0.09, green: 0.20, blue: 0.42, alpha: 1.0)
            alertView.defaultButtonShadowColor = UIColor.white
            alertView.defaultButtonFont = UIFont(name: "OpenSans-Bold", size: 16)
            alertView.defaultButtonTitleColor = UIColor.white
            alertView.show()
            
        } else {
            switch subject_activity {
            case subject_type.guidance:
                main_string_next = guidance_teachers.orderedValues[(indexPath as NSIndexPath).row]
                break
            case subject_type.math:
                main_string_next = math_teachers.orderedValues[(indexPath as NSIndexPath).row]
                break
            case subject_type.science:
                main_string_next = science_teachers.orderedValues[(indexPath as NSIndexPath).row]
                break
            case subject_type.english:
                main_string_next = english_teachers.orderedValues[(indexPath as NSIndexPath).row]
                break
            case subject_type.social_studies:
                main_string_next = social_studies_teachers.orderedValues[(indexPath as NSIndexPath).row]
                break
            case subject_type.foreign_lang:
                main_string_next = foreign_lang_teachers.orderedValues[(indexPath as NSIndexPath).row]
                break
            case subject_type.study_skills:
                main_string_next = study_skills_teachers.orderedValues[(indexPath as NSIndexPath).row]
                break
            case subject_type.business:
                main_string_next = business_teachers.orderedValues[(indexPath as NSIndexPath).row]
                break
            case subject_type.esl:
                main_string_next = esl_teachers.orderedValues[(indexPath as NSIndexPath).row]
                break
            case subject_type.performing_arts:
                main_string_next = performing_arts_teachers.orderedValues[(indexPath as NSIndexPath).row]
                break
            case subject_type.special_ed:
                main_string_next = special_ed_teachers.orderedValues[(indexPath as NSIndexPath).row]
                break
            case subject_type.health:
                main_string_next = health_teachers.orderedValues[(indexPath as NSIndexPath).row]
                break
            case subject_type.phys_ed:
                main_string_next = phys_ed_teachers.orderedValues[(indexPath as NSIndexPath).row]
                break
            }
            
            main_string_next = EMAILPREFIX + main_string_next + EMAILSUFFIX
            
            let full_url = URL(string: main_string_next)
            
            UIApplication.shared.openURL(full_url!)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func alertView(_ alertView: FUIAlertView!, didDismissWithButtonIndex buttonIndex: Int) {
        if (buttonIndex == 0) {
            return
        } else {
            self.phone_string = self.TELPREFIX + self.phone_string
            
            let full_url = URL(string: self.phone_string)
            
            UIApplication.shared.openURL(full_url!)
        }
    }
}
