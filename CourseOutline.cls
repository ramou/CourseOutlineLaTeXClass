\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CourseOutline}[2023/02/28 Package to help make course outlines]
\LoadClass{article}
\RequirePackage[margin=1in]{geometry}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{colortbl}
\RequirePackage{multirow}
\RequirePackage{setspace}
\RequirePackage{rviewport}
\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage{datetime}
\RequirePackage{advdate}
\RequirePackage{tikz}



\RequirePackage{url}
\RequirePackage[normalem]{ulem}


\usetikzlibrary{calc, math, positioning}

\pagestyle{plain}
\setlength\parindent{0pt}

\newcounter{TutorialSection}
\newcounter{LabSection}
\newcounter{CourseBlock}
\newcounter{CourseDays}
\setcounter{TutorialSection}{1}
\setcounter{LabSection}{9}
\setcounter{CourseBlock}{1}
\setcounter{CourseDays}{0}

\definecolor{mygray}{gray}{0.80}

\newcommand{\ShowTutorialSection}{{\ShowCourseSection}\Alph{TutorialSection}}
\newcommand{\ShowLabSection}{N\Alph{LabSection}-X}

%
% Day/Time
% Location
% Name
% Email
%
\NewDocumentCommand{\tutorial}{mmmO{}O{}}{%
\ifdefempty{\@photo}{}{& }\ifodd\value{CourseBlock}{\cellcolor{mygray}}\fi\large Tutorial {\ShowTutorialSection}: #1, #2 \\%
\ifdefempty{\@photo}{}{& }\ifodd\value{CourseBlock}{\cellcolor{mygray}}\fi\large Tutor: #3 \ifblank{#4}{}{(\url{#4})}%
\addtocounter{TutorialSection}{1}%
\addtocounter{CourseBlock}{1}\\
}

\NewDocumentCommand{\lab}{mmmO{}O{}}{%
\ifdefempty{\@photo}{}{& }\ifodd\value{CourseBlock}{\cellcolor{mygray}}\fi \large Lab {\ShowLabSection}: #1, #2 \\%
\ifdefempty{\@photo}{}{& }\ifodd\value{CourseBlock}{\cellcolor{mygray}}\fi \large Tutor: #3 \ifblank{#4}{}{(\url{#4})}%
\addtocounter{LabSection}{1}%
\addtocounter{CourseBlock}{1}\\
}

\NewDocumentCommand{\pod}{mmmO{}O{}}{%
\ifdefempty{\@photo}{}{& }\ifodd\value{CourseBlock}{\cellcolor{mygray}}\fi \large POD {\ShowLabSection}: #1, #2 \\%
\ifdefempty{\@photo}{}{& }\ifodd\value{CourseBlock}{\cellcolor{mygray}}\fi \large Tutor: #3\ifblank{#4}{}{(\url{#4})}%
%
\addtocounter{CourseBlock}{2}\\
}

\NewDocumentCommand{\marker}{O{}O{}}{%
\ifdefempty{\@photo}{}{& }\ifodd\value{CourseBlock}{\cellcolor{mygray}}\fi \large Marker: \ifblank{#1}{TBD}{#1\ifblank{#2}{}{ (\url{#2})}}%
%
\addtocounter{CourseBlock}{1}\\
}

%The University Logo
\newcommand{\@logo}{}
\newcommand{\logo}[1]{\renewcommand{\@logo}{#1}}

%The course
\newcommand{\@courseid}{}
\newcommand{\ShowCourseSection}{}
\newcommand{\@days}{}
\newcommand{\@times}{}
\newcommand{\@location}{}
\NewDocumentCommand{\Course}{m m m m m m}{%
  \renewcommand{\@courseid}{#1}%
  \renewcommand{\ShowCourseSection}{#2}%
  \renewcommand{\@title}{#3}%
  \renewcommand{\@days}{#4}%
  \renewcommand{\@times}{#5}%
  \renewcommand{\@location}{#6}%
}

%The semester
\newcommand{\@sem}{}
\newcommand{\@startsemester}{}
\newcommand{\@endsemester}{}
\NewDocumentCommand{\Semester}{m m m }{%
  \renewcommand{\@sem}{#1}%
  \renewcommand{\@startsemester}{#2}%
  \renewcommand{\@endsemester}{#3}%
}

%The prof
\newcommand{\@ProfName}{}
\newcommand{\@photo}{}
\newcommand{\@ProfEmail}{}
\newcommand{\@OfficeHours}{}
\NewDocumentCommand{\Prof}{m m m O{}}{%
  \renewcommand{\@ProfName}{#1}%
  \renewcommand{\@ProfEmail}{\url{#2}}%
  \renewcommand{\@OfficeHours}{#3}%
  \ifblank{#4}{}{\renewcommand{\@photo}{#4}}%
}


\NewDocumentEnvironment{courseblock}{}{%
\begin{tabular}{ l l }%
\ifdefempty{\@photo}{}{\multirow{6}{*}{\includegraphics[height=1in,width=1in]{ \@photo }}}%
 \ifdefempty{\@photo}{}{& }\large \@ProfName{ }(\@ProfEmail)\\%
 \ifdefempty{\@photo}{}{& }\large Office Hours: \@OfficeHours\\%
 \ifdefempty{\@photo}{}{& }\large Lecture \ShowCourseSection: \@days, \@times, \@location \\%
}{%
 \end{tabular}%
}

\newcounter{rowcount}

\NewDocumentCommand{\LectureEntry}{O{} +m O{white}}{%
\ifblank{#1}{}{\addtocounter{CourseDays}{#1}}%
\addtocounter{rowcount}{1}%
\ifnum\therowcount=1
\node[draw, text width=\dimexpr\linewidth-1in-10pt, fill=#3] (cell2-\therowcount) at (-2*\tabcolsep, -\therowcount) {#2};
\tikzmath{coordinate \C;
\C = (cell2-\therowcount.north)-(cell2-\therowcount.south);
\myheight = sqrt((\Cx)^2+(\Cy)^2); 
}
\node[draw, minimum height=\myheight, anchor=north east, align=center,fill=#3] (cell1-\therowcount) at (cell2-\therowcount.north west) {\ifblank{#1}{TBD}{\AdvanceDate[\value{CourseDays}]\today}};
\else
\node[draw, text width=\dimexpr\linewidth-1in-10pt, anchor=north west, fill=#3] (cell2-\therowcount) at (cell2-\the\numexpr\therowcount-1.south west) {#2};
\tikzmath{coordinate \C;
\C = (cell2-\therowcount.north)-(cell2-\therowcount.south);
\myheight = sqrt((\Cx)^2+(\Cy)^2); 
}
\node[draw, minimum height=\myheight, align=center, anchor=north east, fill=#3] (cell1-\therowcount) at (cell2-\therowcount.north west) {\ifblank{#1}{TBD}{\AdvanceDate[\value{CourseDays}]\today}};
\fi
}

\NewDocumentEnvironment{DetailedOutline}{m}{%
\setcounter{rowcount}{0}
\textbf {\large #1}:\\\\
\begin{center}
\hyphenchar\font=-1
\begin{tikzpicture}[every node/.style={draw=black, align=flush left,font=\fontsize{11.5pt}{12pt}\selectfont, outer sep=0pt, minimum height=0.6cm,inner sep=3pt, inner xsep=5pt, text width=1.2in}]
}{
\node[draw, text width=\dimexpr\linewidth-1in-10pt, anchor=south west] (cell2-header) at (cell2-1.north west) {\textbf{Content}};
\node[draw, align=center, anchor=south west] (cell1-header) at (cell1-1.north west) {\textbf{Day}};
\end{tikzpicture}
\hyphenchar\font=1
\end{center}
}

\renewcommand{\maketitle}{%
% Course information
\begin{tabular}{ l l }%
  \multirow{3}{*}{\includegraphics[height=1in,width=1in]{\@logo}}%
  & \LARGE \@courseid{ }\ShowCourseSection,{ \@sem} \\\\%
  & \LARGE \@title \\\\%
  & \LARGE \@days, \@times, Location: \@location \\\\%
  & \LARGE \@startsemester{ till }\@endsemester\\\\%
\end{tabular}%
}


\newdateformat{myshortdate}{%
\shortdayofweekname{\THEDAY}{\THEMONTH}{\THEYEAR} \ordinaldate{\THEDAY} \shortmonthname[\THEMONTH]}
\myshortdate


