//
//  Data.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 13/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import Foundation

enum CourseType {
    case MandatoryMajor
    case NonMandatoryMajor
    case LiberalCourse
    case NonMandatoryCourse
}

func currentCredit(type: CourseType) -> Int {
    switch type {
    case .MandatoryMajor:
        return courseSets.filter({$0.lectureType == 0}).map { (cInfo) -> Int in return cInfo.credit}.reduce(0, +)
    case .NonMandatoryMajor:
        return courseSets.filter({$0.lectureType == 1}).map { (cInfo) -> Int in return cInfo.credit}.reduce(0, +)
    case .LiberalCourse:
        return courseSets.filter({$0.lectureType == 2}).map { (cInfo) -> Int in return cInfo.credit}.reduce(0, +)
    default:
        return courseSets.filter({$0.lectureType == 3}).map { (cInfo) -> Int in return cInfo.credit}.reduce(0, +)
    }
}

func creditNeeded(year: Int, type: CourseType) -> Int {
    switch year {
    case 2018:
        switch type {
        case .MandatoryMajor: return 32
        case .NonMandatoryMajor: return 31
        case .LiberalCourse: return 50
        default: return 10
        }
    case 2017:
        switch type {
        case .MandatoryMajor: return 28
        case .NonMandatoryMajor: return 35
        case .LiberalCourse: return 50
        default: return 10
        }
    case 2016:
        switch type {
        case .MandatoryMajor: return 28
        case .NonMandatoryMajor: return 35
        case .LiberalCourse: return 50
        default: return 10
        }
    case 2015:
        switch type {
        case .MandatoryMajor: return 28
        case .NonMandatoryMajor: return 35
        case .LiberalCourse: return 50
        default: return 10
        }
    case 2014:
        switch type {
        case .MandatoryMajor: return 28
        case .NonMandatoryMajor: return 35
        case .LiberalCourse: return 50
        default: return 10
        }
    default:
        switch type {
        case .MandatoryMajor: return 32
        case .NonMandatoryMajor: return 31
        case .LiberalCourse: return 50
        default: return 10
        }
    }
}

func creditPercent(year: Int, type: CourseType) -> Double {
    return Double(100*currentCredit(type: type))/Double(creditNeeded(year: year, type: type))
}
