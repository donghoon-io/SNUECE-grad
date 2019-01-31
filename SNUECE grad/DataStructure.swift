//
//  DataStructure.swift
//  SNUECE grad
//
//  Created by Donghoon Shin on 07/01/2019.
//  Copyright © 2019 Donghoon Shin. All rights reserved.
//

import Foundation

struct CourseInfo: Codable {
    
    var name: String // ex) "기초회로이론 및 실험"
    var semester: Int // ex) "3학년 1학기" -> "31"
    var credit: Int // ex) 3
    var lectureType: Int // 0: 전필, 1: 전선, 2: 교양, 3: 일선
    
    init(name: String, semester: Int, credit: Int, lectureType: Int) {
        self.name = name
        self.semester = semester
        self.credit = credit
        self.lectureType = lectureType
    }
}


var semesterList: [Int] {
    get {
        return UserDefaults.standard.array(forKey: "semesterList") as? [Int] ?? [11,12,21,22,31]
    } set {
        UserDefaults.standard.set(newValue, forKey: "semesterList")
        UserDefaults.standard.synchronize()
    }
}

var courseSets: [CourseInfo] {
    get {
        let data1 = UserDefaults.standard.value(forKey: "courseSets") as? Data
        let courseSets2 = try? PropertyListDecoder().decode(Array<CourseInfo>.self, from: data1!)
        return courseSets2 ?? coursePreset
    } set {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "courseSets")
        UserDefaults.standard.synchronize()
    }
}

var myName: String {
    get {
        return UserDefaults.standard.string(forKey: "myName") ?? "이름이 없습니다"
    } set {
        UserDefaults.standard.set(newValue, forKey: "myName")
        UserDefaults.standard.synchronize()
    }
}

var myId: String {
    get {
        return UserDefaults.standard.string(forKey: "myId") ?? "이름이 없습니다"
    } set {
        UserDefaults.standard.set(newValue, forKey: "myId")
        UserDefaults.standard.synchronize()
    }
}

var myPassword: String {
    get {
        return UserDefaults.standard.string(forKey: "myPassword") ?? "이름이 없습니다"
    } set {
        UserDefaults.standard.set(newValue, forKey: "myPassword")
        UserDefaults.standard.synchronize()
    }
}

var currentGrade: Int {
    get {
        return UserDefaults.standard.integer(forKey: "currentGrade")
    } set {
        UserDefaults.standard.set(newValue, forKey: "currentGrade")
        UserDefaults.standard.synchronize()
    }
}

var currentType: Int {
    get {
        return UserDefaults.standard.integer(forKey: "currentType")
    } set {
        UserDefaults.standard.set(newValue, forKey: "currentType")
        UserDefaults.standard.synchronize()
    }
}

var isNotInitial: Bool {
    get {
        return UserDefaults.standard.bool(forKey: "notInitial")
    } set {
        UserDefaults.standard.set(newValue, forKey: "notInitial")
        UserDefaults.standard.synchronize()
    }
}

let semesterPreset: [Int] = [11,12,21,22,31]

let coursePreset: [CourseInfo] = [CourseInfo(name: "기초회로이론 및 실험", semester: 21, credit: 3, lectureType: 1), CourseInfo(name: "프로그래밍 방법론", semester: 22, credit: 4, lectureType: 0), CourseInfo(name: "심리학개론", semester: 12, credit: 3, lectureType: 2), CourseInfo(name: "비주얼라이제이션", semester: 11, credit: 3, lectureType: 3),CourseInfo(name: "수학 및 연습 1", semester: 11, credit: 3, lectureType: 2),CourseInfo(name: "물리학 1", semester: 11, credit: 3, lectureType: 2)]
