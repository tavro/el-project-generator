;; Open file in other buffer
;; and make first buffer active
(defun open-file-in-other-buffer (dir-name)
  (switch-to-buffer-other-window (find-file-noselect dir-name))
  (other-window 1))

;; Create directory with given name
(defun mk-dir (dir-name)
  (make-directory dir-name))

;; Create empty file with given name
;; in given directory
(defun mk-file (dir-name file-name)
  (mk-dir dir-name)
  (make-empty-file (concat dir-name (concat "/" file-name))))

;; Get standardized main function
;; as string
(defun write-main()
  ;; Basically returns a string
  ;; since a string gets evaluated
  (setq main "void main()\n{\n\n}\n"))

;; Create custom project structure
;; for D lang
(defun init-d-project (project-name)
  (mk-file project-name "main.d")
  (write-region
   (concat "import std.stdio;\n\n" (write-main))
   nil (concat project-name "/main.d"))
  (open-file-in-other-buffer (concat project-name "/main.d")))

;; Create custom project structure
;; depending on given language
(defun init-project-structure (project-name lang)
  (when (string= lang "d") (init-d-project project-name)))

(init-project-structure "d-project" "d")
