////////////////////////////////////////////////////////////////////////////////////////////////////
Invariant:  vc-lab-1
Description: "Bundle SHOULD only include results with status final or status that is subsequent to final."
Severity:   #error

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant: name-invariant
Description: "Require one of the key name elements to be filled. Allows for `text` for [names that cannot be cleanly categorized into `family` or `given`](https://www.nature.com/articles/d41586-020-02761-z)."
Expression: "family.exists() or given.exists() or text.exists()"
Severity: #error

////////////////////////////////////////////////////////////////////////////////////////////////////