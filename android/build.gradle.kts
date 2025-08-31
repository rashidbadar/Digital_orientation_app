// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.1.1") // Compatible with recent Flutter
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.10") // Kotlin plugin
        classpath("com.google.gms:google-services:4.4.0") // Only if using Firebase/Google services
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Fix build directories for Kotlin DSL
rootProject.buildDir = file("../build")

subprojects {
    project.buildDir = file("${rootProject.buildDir}/${project.name}")
    evaluationDependsOn(":app")
}

// Clean task in Kotlin DSL
tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
