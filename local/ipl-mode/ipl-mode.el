;;; ipl-mode.el --- Emacs mode for Imandra Protocol Language
;;
;; Copyright (c) 2020 Imandra, Inc.
;;
;; Author: Matt Bray <matt@imandra.ai>
;; URL: https://github.com/aestheticintegration/ipl-spacemacs-layer
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(require 'lsp-mode)

(defcustom ipl-path-to-language-server "ipl-server"
  "Path to the IPL language server binary.")
(defcustom ipl-java-home nil
  "Path to Java home")

(defconst ipl-keywords
  '("None"
    "Some"
    "TimeStampPrecisions"
    "VerificationPacks"
    "abs"
    "action"
    "add"
    "alias"
    "anonymous"
    "assignFrom"
    "assignable"
    "break"
    "case"
    "dataset"
    "datatype"
    "declare"
    "default"
    "delete"
    "description"
    "else"
    "enum"
    "events"
    "extend"
    "false"
    "for"
    "forall"
    "function"
    "get"
    "getDefault"
    "if"
    "ign"
    "ignore"
    "imandramarkets"
    "import"
    "in"
    "insert"
    "intOfString"
    "interLibraryCheck"
    "internal"
    "invalid"
    "invalidfield"
    "let"
    "library"
    "libraryMarker"
    "list"
    "map"
    "mapAdd"
    "message"
    "micro"
    "milli"
    "missingfield"
    "name"
    "opt"
    "option"
    "optional"
    "outbound"
    "overloadFunction"
    "overrideFieldTypes"
    "precision"
    "present"
    "receive"
    "record"
    "reject"
    "remove"
    "repeating"
    "repeatingGroup"
    "req"
    "require"
    "return"
    "scenario"
    "send"
    "service"
    "set"
    "strLen"
    "subset"
    "testfile"
    "then"
    "toFloat"
    "toInt"
    "true"
    "truncate"
    "unique"
    "valid"
    "validate"
    "when"
    "with"
    ))


(define-derived-mode ipl-mode
  text-mode "IPL"
  "Major mode for Imandra Protocol Language."
  (progn
    (setq comment-start "//")
    (setq comment-start-skip "//\\s *")
    (setq ipl-highlights
          `(("//.+" . font-lock-comment-face)
            (,(regexp-opt ipl-keywords 'word) . font-lock-keyword-face)))
    (setq font-lock-defaults '(ipl-highlights))))

(add-to-list 'lsp-language-id-configuration '(ipl-mode . "IPL"))

(lsp-register-client
 (make-lsp-client
  :new-connection
  (lsp-stdio-connection
   (lambda () ipl-path-to-language-server))
  :major-modes '(ipl-mode)
  :server-id 'imandra-ipl-lsp
  :environment-fn (lambda ()
                    (if ipl-java-home
                        '(("JAVA_HOME" . ipl-java-home))
                      '()))))

(add-to-list 'ipl-mode-hook #'lsp-mode)

(provide 'ipl-mode)
