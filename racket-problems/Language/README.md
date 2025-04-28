# THE SIMPL and PRIMPL Languages 💻

I created two languages to deepen my understanding of how computers work. **SIMPL** (Simple IMPerative Language) mimics the fundamentals of imperative programming—it supports loops, mutation, sequencing, and more. **PRIMPL** (PRImitive IMPerative Language) focuses on emulating a low-level machine language: there’s no nesting, only one statement per line, and it omits labels and constants just like real machine code.

## PRIMPL-A: The Assembly Layer ⚙️

Since most machine languages include labels, constants, and variables, I designed **PRIMPL-A** to wrap PRIMPL with these features. To support PRIMPL-A, I built an assembler called **PRIMPLIFIER**.

## Compilers: From SIMPL to PRIMPL-A and Beyond 🚀

- **Compiler1**: Translates SIMPL code into PRIMPL-A. This was one of the most exciting challenges I’ve tackled!
- **Compiler2**: Extends SIMPL by adding functions, recursion, and arrays—resulting in **SIMPL-FA** (Functions & Arrays).

# Interpreters

I also wrote three **Faux Racket** interpreters in **Racket** (LOL), each gradually introducing mutable state. Read the comments at the start of each file to see how it evolves from pure functional code to full-blown mutation with boxes and everything.

# What I Learned 💡

Working on this project taught me a lot about computer architecture, including:

- Function call overhead
- Benefits of loops vs. recursion
- Tail-call optimization
- And much more!

---

Ready to explore these languages? Dive in and have fun! 🎉

---

**P.S.** This work was completed as part of the Algorithm Design and Data Abstraction (Enriched) course.

