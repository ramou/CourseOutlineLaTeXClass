# CourseOutlineLaTeXClass

I got tired of the duplication involved in making my course outlines and I wanted to focus on the important stuff. I also was feeling picky about how stuff looked, hence my crappy go at tikz for laying out the course summaries. I should fix that up so it does the sizing and alignment properly...


## Sample
main.tex gives a sample usage.

```LaTeX
 \SetDate[09/01/2023]
 \logo{img/CONU-logo-clr.png}
 \Course{COEN 244}{S}{Programming Methodology II}{M/W}{13:15-14:30}{MB 1.210}
 \Semester{Fall 2021}{Jan 9th}{Apr 17th}
 \Prof{Stuart Thiel}{stuart.thiel@gmail.com}{Zoom, by appointment}[img/stuart.jpg]
```

In the preamble you set the date of the first class, give your University logo (140x140, preferably). Give the course details (may have to tweak that for other Universities), the semester details and finally your own details (140x140 picture of you is optional).

```LaTeX
\maketitle
```

Will make the initial stuff at the top (Uni logo and course info)

```LaTeX
\begin{courseblock}
\tutorial{Th, 16:15-17:55}{H 907}{Mina Masoumi}[minamasoomi31@gmail.com]
\tutorial{Th, 16:15-17:35}{H 847}{Ismael Ridha}[ismaelmergasori@gmail.com]
\tutorial{F, 16:15-17:55}{H 917}{Mustafa Daraghmeh}[mustafa.daraghmeh@concordia.ca]
\tutorial{F, 16:15-17:55}{H 843}{Zaedul Islam}[islam.zaedul@gmail.com]\addtocounter{TutorialSection}{2}%
\tutorial{Th, 16:05-17:45}{H 903}{Zaedul Islam}[islam.zaedul@gmail.com]
\marker[Mohammad Reza Rejali][mohammadreza.rejali@concordia.ca]
\marker[Ismael Ridha][ismaelmergasori@gmail.com]
\end{courseblock}
```

You can get the blurb with the main lecture info and all you tutorial/tutors info. If you leave out the emails, they just don't show. If you leave out both the name and email it should say TBD. The courseblock formats it nicelym sticks the main lecture info and your info


```LaTeX
\begin{DetailedOutline}{Course Outline - First Half}
\LectureEntry[0]{
    Course Description \textbf{\small Outline}
}
\LectureEntry[2]{
    \textbf{Live-Coding} \\
    Overview of C++ (main function, cin/cout, variables and constants, arrays, enumerated types, If-else, loops, strings, functions, pointers, namespaces, structures) \textbf{Ch. 1‐8 (COEN 243 Concepts)} \\
    Making tic-tac-toe}
\LectureEntry[5]{
    C++ Classes (Data abstraction, classes and objects, encapsulation, data members, function members, constructors and destructors) \textbf{Ch. 3, 9}
}
\LectureEntry[2]{
    Midterm Break
}[gray!25]
\end{DetailedOutline}
```
The DetailedOutline environment takes a parameter that is the blurb at the top. This should fit on a single page, though I imagine I could fix that to span pages if I were ambitious. Each LectureEntry gets formatted with the date in the left column and the content of the LectureEntry in the right column. The date comes from the first optional parameter and is initially an offset from the StartingDate speceified in the preamble. The counter tracking the date increments each time, so each entry is relative to the last. If you leave out the optional first param, the date is listed as TBD and it doesn't mess with the date counter. You can specify a row color as an optional last parameter.

## Everything else
The rest you can format as you'd like. The format used here is based of the reccomended on in the GCS at Concordia, and the pdf is just me converting the GAAS word document (after I move section 3 to start on its own page) to pdf and importing them all.
