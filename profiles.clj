{:user 
 {:aliases {"slamhound" ["run" "-m" "slam.hound"]
            "rebl" ["run" "-m" "cognitect.rebl"]}
  :plugins [; lets you try dependencies without a project.clj: `lein try clj-time "0.5.1"`
            ; (version is optional, defaults to "RELEASE")
            #_[lein-try "RELEASE"]
            ; warn about outdated versions
            #_[lein-ancient "RELEASE"]
            ; pprint a representation of the project map
            #_[lein-pprint "RELEASE"]
            ; alias common things in user ns for use in repl. Configured below. Usage:
            #_[com.gfredericks/lein-shorthand "RELEASE"]
            ]
  :dependencies [; automatically remove and add requirements in namespaces
                 #_[slamhound "RELEASE"]
                 #_[alembic "RELEASE"]
                 ]
  ;:resource-paths ["resources/REBL-0.9.157.jar"] ; appears only absolute paths work
  :resource-paths ["/Users/pjagielski/Downloads/REBL-0.9.157/REBL-0.9.157.jar"]
  :shorthand {. {#_ #_pp clojure.pprint/pprint
                 ; adds dependency to classpath: (./add-dep '[foo.bar "version"])
                 #_#_add-dep alembic.still/distill
                 ; reloads project.clj
                 #_#_load-project alembic.still/load-project
                 ; calls leiningen: (./lein deps :tree)
                 #_#_lein alembic.still/lein
                 }}}
 :auth {:repository-auth {#"my\.datomic\.com" {:username "philipjagielski@gmail.com"
                                               :password "c177a5ad-556d-4fb5-9950-975d9be4ca0d"}}}
 }
