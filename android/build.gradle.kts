import com.android.build.gradle.LibraryExtension

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = rootProject.layout.buildDirectory.dir(project.name).get()
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// --- FIX UNTUK ISAR & PLUGIN LAMA YANG TIDAK PUNYA NAMESPACE ---
subprojects {
    afterEvaluate {
        if (plugins.hasPlugin("com.android.library")) {
            configure<LibraryExtension> {
                if (namespace == null) {
                    namespace = "com.example." + project.name.replace("-", "_")
                }
            }
        }
    }
}