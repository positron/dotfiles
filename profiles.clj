{:user 
 {:aliases {"slamhound" ["run" "-m" "slam.hound"]}
  :plugins [; lets you try dependencies without a project.clj: `lein try clj-time "0.5.1"`
            ; (version is optional, defaults to "RELEASE")
            [lein-try "RELEASE"]
            ; warn about outdated versions
            [lein-ancient "RELEASE"]
            ; pprint a representation of the project map
            [lein-pprint "RELEASE"]
            ]
  :dependencies [; automatically remove and add requirements in namespaces
                 [slamhound "RELEASE"]
                 ]}}
