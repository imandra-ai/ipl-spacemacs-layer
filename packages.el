;;; packages.el --- ipl layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Matt Bray <mattjbray@Matts-iMac.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `ipl-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `ipl/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `ipl/pre-init-PACKAGE' and/or
;;   `ipl/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst ipl-packages
  '(
    company
    flycheck
    lsp-mode
    smartparens
    )
  "The list of Lisp packages required by the ipl layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun ipl/init-lsp-mode ()
  (use-package lsp-mode
    :mode ("\\.ipl\\'" . ipl-mode)
    :init
    (progn
      (add-to-list 'ipl-mode-hook #'lsp-mode)
      )
    :config
    (progn
      (require 'lsp-flycheck)
      (setq lsp-print-io nil)
      (setq lsp-document-sync-method 'full)
      (lsp-define-stdio-client 'ipl-mode "ipl" 'stdio
                               #'(lambda () default-directory)
                               "Imandra Protocol Language Language Server"
                               ipl-path-to-language-server
                               )
      (spacemacs/set-leader-keys-for-major-mode 'ipl-mode "gg" 'xref-find-definitions)
      )
    ))

(defun ipl/post-init-company ()
  ;; (spacemacs|add-company-hook ipl-mode)
  (add-hook 'ipl-mode-hook #'company-mode)
  )

(defun ipl/post-init-flycheck ()
  ;; (with-eval-after-load 'lsp-mode
  ;;   (require 'lsp-flycheck))
  (add-hook 'ipl-mode-hook #'flycheck-mode))

(defun ipl/post-init-smartparens ()
  (if dotspacemacs-smartparens-strict-mode
      (add-hook 'ipl-mode-hook #'smartparens-strict-mode)
    (add-hook 'ipl-mode-hook #'smartparens-mode)))

;;; packages.el ends here
