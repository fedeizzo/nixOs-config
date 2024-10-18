;;; jinx.el --- Package to check the spelling

;;; Commentary:
;;

;;; Code:
(use-package jinx
  :custom
  (jinx-languages . "en")
  :hook (emacs-startup . global-jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-languages)))

;;; jinx.el ends here
