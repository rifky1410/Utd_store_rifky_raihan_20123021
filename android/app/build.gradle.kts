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

// FIX 1: UNTUK ISAR NAMESPACE AGP 8+ (Aman dan didukung oleh kompilator Flutter)
subprojects {
    project.plugins.withId("com.android.library") {
        project.extensions.configure<com.android.build.gradle.LibraryExtension>("android") {
            if (namespace == null) {
                namespace = "com.example." + project.name.replace("-", "_")
            }
        }
    }
}

// FIX 2: PENYUSUP OTOMATIS (Menghapus atribut yang dilarang dari dalam cache GitHub/Lokal)
gradle.projectsEvaluated {
    subprojects {
        if (project.name == "isar_flutter_libs") {
            val manifestFile = file("${project.projectDir}/src/main/AndroidManifest.xml")
            if (manifestFile.exists()) {
                val content = manifestFile.readText()
                if (content.contains("package=\"dev.isar.isar_flutter_libs\"")) {
                    manifestFile.writeText(content.replace("package=\"dev.isar.isar_flutter_libs\"", ""))
                    println("✅ Berhasil menghapus atribut package yang dilarang dari isar_flutter_libs!")
                }
            }
        }
    }
}