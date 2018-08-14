{:user 
 {:aliases {"slamhound" ["run" "-m" "slam.hound"]}
  :plugins [; lets you try dependencies without a project.clj: `lein try clj-time "0.5.1"`
            ; (version is optional, defaults to "RELEASE")
            [lein-try "RELEASE"]
            ; warn about outdated versions
            [lein-ancient "RELEASE"]
            ; pprint a representation of the project map
            [lein-pprint "RELEASE"]
            ; alias common things in user ns for use in repl. Configured below. Usage:
            [com.gfredericks/lein-shorthand "RELEASE"]
            ]
  :dependencies [; automatically remove and add requirements in namespaces
                 [slamhound "RELEASE"]
                 [alembic "RELEASE"]
                 ]
  :shorthand {. {pp clojure.pprint/pprint
                 ; adds dependency to classpath: (./add-dep '[foo.bar "version"])
                 add-dep alembic.still/distill
                 ; reloads project.clj
                 load-project alembic.still/load-project
                 ; calls leiningen: (./lein deps :tree)
                 lein alembic.still/lein
                 }}}}
