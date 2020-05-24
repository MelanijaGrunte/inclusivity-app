//
//  Settings.swift
//  Inclusivity
//
//  Created by Melānija Grunte on 13/05/2020.
//  Copyright © 2020 makit. All rights reserved.
//

import UIKit

// swiftlint:disable identifier_name
public enum DisabilitySection: String, CaseIterable {
    case visual, hearing, motor, cognitive
    
    var title: String {
        switch self {
        case .visual: return "Redzes traucējumi"
        case .hearing: return "Dzirdes traucējumi"
        case .motor: return "Kustību traucējumi"
        case .cognitive: return "Kognitīvi traucējumi"
        }
    }
    
    var cells: [DisabilityCell] {
        switch self {
        case .visual: return [.blur, .ghosting, .floaters, .visual_snow, .color_blindness, .glare, .glaucoma, .blindness, .cataracts, .macular_degeneration, .retinal_detachment, .diabetic_retinopathy, .hemianopia]
        case .hearing: return [.complete, .partial]
        case .motor: return [.no_pinch, .no_tap, .no_rotation, .no_swipe, .no_pan, .no_screen_edge_pan, .no_long_press]
        case .cognitive: return [.slowness, .seizures, .illiteracy, .dyslexia, .adhd, .dyscalculia, .dysgraphia, .processing_deficits]
        }
    }
}

/*
 
 case is UITapGestureRecognizer:
     gestureRecognizer.isEnabled = UserDefaults.standard.bool(forKey: DisabilityCell.none.rawValue)
 case is UIPinchGestureRecognizer:
     gestureRecognizer.isEnabled = UserDefaults.standard.bool(forKey: DisabilityCell.none.rawValue)
 case is UIRotationGestureRecognizer:
     gestureRecognizer.isEnabled = UserDefaults.standard.bool(forKey: DisabilityCell.none.rawValue)
 case is UISwipeGestureRecognizer:
     gestureRecognizer.isEnabled = UserDefaults.standard.bool(forKey: DisabilityCell.none.rawValue)
 case is UIPanGestureRecognizer:
     gestureRecognizer.isEnabled = UserDefaults.standard.bool(forKey: DisabilityCell.none.rawValue)
 case is UIScreenEdgePanGestureRecognizer:
     gestureRecognizer.isEnabled = UserDefaults.standard.bool(forKey: DisabilityCell.none.rawValue)
 case is UILongPressGestureRecognizer:
     gestureRecognizer.isEnabled = UserDefaults.standard.bool(forKey: DisabilityCell.none.rawValue)
 
 */

public enum DisabilityCell: String, CaseIterable {
    case
    blur, ghosting, floaters, visual_snow, color_blindness, glare, glaucoma, blindness, cataracts, macular_degeneration, retinal_detachment, diabetic_retinopathy, hemianopia,
    no_pinch, no_tap, no_rotation, no_swipe, no_pan, no_screen_edge_pan, no_long_press,
    slowness, seizures, illiteracy, dyslexia, adhd, dyscalculia, dysgraphia, processing_deficits,
    complete, partial
    
    var description: String {
        switch self {
        case .blur: return "Vāja redze (zems asums)"
        case .ghosting: return "Dubultošanās (diplopija)"
        case .floaters: return "Acu pludiņi (muscae volitantes)"
        case .visual_snow: return "Vizuālais sniegs"
        case .color_blindness: return "Krāsu aklums"
        case .glare: return "Atspīdums, žilbinājums"
        case .glaucoma: return "Glaukoma"
        case .blindness: return "Aklums"
        case .cataracts: return "Katarakta"
        case .macular_degeneration: return "Mākulas deģenerācija"
        case .retinal_detachment: return "Tīklenes atslāņošanās"
        case .diabetic_retinopathy: return "Diabētiskā retinopātija"
        case .hemianopia: return "Hemianopija"
            
        case .no_pinch: return "bez pinch"
        case .no_tap: return "bez tap"
        case .no_rotation: return "bez rotation"
        case .no_swipe: return "bez swipe"
        case .no_pan: return "bez pan"
        case .no_screen_edge_pan: return "bez screen edge pan"
        case .no_long_press: return "bez long press"
            
        case .slowness: return "vispārējs"
        case .seizures: return "seizures"
        case .illiteracy: return "analfabētisms"
        case .dyslexia: return "teksta uztveršanas problēmas"
        case .adhd: return "uzmanības deficīts"
        case .dyscalculia: return "problēmas ar matemātiku, skaitļiem"
        case .dysgraphia: return "rakstīšanas problēmas"
        case .processing_deficits: return "uztveres problēmas"
            
        case .complete: return "Kurlums"
        case .partial: return "Vāja dzirde"
        }
    }
    
    var details: [DisabilityDetail] {
        switch self {
        case .blur: return [.blur_intensity]
        case .ghosting: return [.blur_of_background, .blur_of_ghost, .ghost_opacity]
        case .floaters: return []
        case .visual_snow: return []
        case .color_blindness: return [.protanopia, .protanomaly, .deuteranopia, .deuteranomaly, .tritanopia, .tritanomaly, .achromatopsia, .achromatomaly]
        case .glare: return []
        case .glaucoma: return []
        case .blindness: return []
        case .cataracts: return [.cataracts_intensity]
        case .macular_degeneration: return []
        case .retinal_detachment: return []
        case .diabetic_retinopathy: return []
        case .hemianopia: return []
            
        case .no_pinch: return []
        case .no_tap: return [.gesture_tap_number_of_taps_required, .gesture_tap_number_of_touches_required]
        case .no_rotation: return []
        case .no_swipe: return []
        case .no_pan: return []
        case .no_screen_edge_pan: return []
        case .no_long_press: return []
            
        case .slowness: return []
        case .seizures: return []
        case .illiteracy: return []
        case .dyslexia: return []
        case .adhd: return []
        case .dyscalculia: return []
        case .dysgraphia: return []
        case .processing_deficits: return []
            
        case .complete: return []
        case .partial: return []

        }
    }
    
    var implemented: Bool {
        switch self {
        case .blur, .ghosting, .floaters, .color_blindness, .cataracts: return true

        case .visual_snow, .glare, .blindness, .glaucoma, .macular_degeneration: return false

        case .retinal_detachment: return true
        case .diabetic_retinopathy: return true
        case .hemianopia: return true
            
        case .no_pinch, .no_rotation, .no_swipe, .no_pan, .no_long_press, .no_screen_edge_pan: return false
        case .no_tap: return true
            
        case .slowness, .seizures, .illiteracy, .dyslexia, .adhd, .dyscalculia, .dysgraphia, .processing_deficits: return false
            
        case .complete, .partial: return false
        }
    }
}

public enum DisabilityDetail: String, CaseIterable {
    case blur_intensity, // blur
    blur_of_background, blur_of_ghost, ghost_opacity, // ghosting
    cataracts_intensity, // cataracts opacity no 0 līdz 20
    gesture_tap_number_of_taps_required, gesture_tap_number_of_touches_required, // gestures
    protanopia, protanomaly, deuteranopia, deuteranomaly, tritanopia, tritanomaly, achromatopsia, achromatomaly // color blindness
    
    var description: String {
        switch self {
        case .blur_intensity: return "Miglainuma intensitāte"
        case .blur_of_background: return "Fona miglainums"
        case .blur_of_ghost: return "Dubultošanās miglainums"
        case .ghost_opacity: return "Dubultošanās necaurredzamība"
        case .cataracts_intensity: return "Katarakta intensitāte"
        case .protanopia: return "Protanopija"
        case .protanomaly: return "Protanomālija"
        case .deuteranopia: return "Deiteranopija"
        case .deuteranomaly: return "Deiteranomālija"
        case .tritanopia: return "Tritanopija"
        case .tritanomaly: return "Tritanomālija"
        case .achromatopsia: return "Ahromatopsija"
        case .achromatomaly: return "Ahromatomālija"
        case .gesture_tap_number_of_taps_required: return "Nepieciešamais pirkstu skaits"
        case .gesture_tap_number_of_touches_required: return "Nepieciešamais atkārtotu pieskārienu skaits"
        }
    }
    
    var configType: DetailConfigurationType {
        switch self {
        case .blur_intensity: return .slider_percentage
        case .blur_of_background: return .slider_percentage
        case .blur_of_ghost: return .slider_percentage
        case .ghost_opacity: return .slider_percentage
        case .cataracts_intensity: return .slider_percentage
        case .protanopia: return .one_of
        case .protanomaly: return .one_of
        case .deuteranopia: return .one_of
        case .deuteranomaly: return .one_of
        case .tritanopia: return .one_of
        case .tritanomaly: return .one_of
        case .achromatopsia: return .one_of
        case .achromatomaly: return .one_of
        case .gesture_tap_number_of_taps_required: return .slider_count_0_to_5
        case .gesture_tap_number_of_touches_required: return .slider_count_0_to_5
        }
    }
}

public enum DetailConfigurationType: String, CaseIterable {
    case slider_percentage, slider_count_0_to_5, uiswitch, one_of
}
