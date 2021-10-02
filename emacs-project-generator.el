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

;; Get html <head>-skeleton
;; as string
(defun write-html-head ()
  (setq head "<head>\n<meta charset=\"UTF-8\">\n<title>Title</title>\n<link rel=\"stylesheet\" href=\"#\">\n<style></style>\n<script src=\"#\"></script>\n</head>\n\n"))

;; Get html <body>-skeleton
;; as string
(defun write-html-body ()
  (setq body "<body>\n<div class=\"main\">\n<h1>Header</h1>\n<p>Paragraph</p>\n</div>\n</body>\n"))

;; Create custom project structure
;; for html and css
(defun init-html-css (project-name)
  (mk-file project-name "index.html")
  (write-region
   (concat "<!DOCTYPE html>\n<html lang=\"en\">\n"
	   (concat (write-html-head)
		   (concat (write-html-body) "</html>")))
   nil (concat project-name "/index.html"))
  (mk-file (concat project-name "/stylesheet") "style.css")
  (mk-dir (concat project-name "/img"))
  (mk-dir (concat project-name "/js")))

;; Create custom project structure
;; for D lang
(defun init-d (project-name)
  (mk-file project-name "main.d")
  (write-region
   (concat "import std.stdio;\n\n" (write-main))
   nil (concat project-name "/main.d"))
  (open-file-in-other-buffer (concat project-name "/main.d")))

;; Create custom project structure
;; depending on given language
(defun init-project-structure (project-name lang)
  (when (string= lang "d") (init-d project-name))
  (when (string= lang "html-css") (init-html-css project-name)))

(init-project-structure "website" "html-css")
