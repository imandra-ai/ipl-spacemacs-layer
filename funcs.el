;;; funcs.el --- ipl layer functions File for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Matt Bray <mattjbray@Matts-iMac.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst ipl-keywords
  '(
    "None"
    "Some"
    "VerificationPacks"
    "a"
    "action"
    "alias"
    "assignFrom"
    "assignable"
    "case"
    "datatype"
    "declare"
    "default"
    "else"
    "enum"
    "extend"
    "false"
    "if"
    "imandramarkets"
    "import"
    "in"
    "internal"
    "invalid"
    "invalidfield"
    "let"
    "library"
    "m"
    "message"
    "missingfield"
    "opt"
    "optional"
    "outbound"
    "overloadFunction"
    "precision"
    "present"
    "receive"
    "record"
    "reject"
    "repeating"
    "req"
    "require"
    "return"
    "send"
    "then"
    "toFloat"
    "toInt"
    "true"
    "unique"
    "valid"
    "validate"
    "when"
    "with"
    ))


(define-derived-mode ipl-mode
  text-mode "IPL"
  "Major mode for Imandra Protocol Language."
  (setq font-lock-defaults
        `((
           ,(regexp-opt ipl-keywords 'words)
           ))
        )
  )

;; (add-to-list 'auto-mode-alist '("\\.ipl\\'" . ipl-mode))
