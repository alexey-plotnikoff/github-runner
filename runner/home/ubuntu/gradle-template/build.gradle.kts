plugins {
    application
}

repositories {
    mavenCentral()
}

// Usage: ./gradlew playwright --args="help"
tasks.register<JavaExec>("playwright") {
    classpath(sourceSets["test"].runtimeClasspath)
    mainClass.set("com.microsoft.playwright.CLI")
}

dependencies {
    implementation("com.microsoft.playwright:playwright:1.57.0")
}
