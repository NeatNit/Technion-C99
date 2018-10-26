הוראות התקנה ל-C99 ב-Sublime Text עבור מבוא למדעי המחשב בטכניון:
1. להוריד ולהתקין Sublime Text כמובן מהאתר: https://www.sublimetext.com/
2. להוריד ולהתקין https://osdn.net/dl/mingw/mingw-get-setup.exe - לא לשנות מיקום התקנה! יש גם לוודא שהאפשרות ל-graphical user interface מסומנת
3. להריץ את MinGW Installation Manager, לבחור בצד שמאל Basic Setup ולסמן את: mingw32-base-bin
4. ללחוץ על: Installation -> Apply Changes
5. לאפשר להתקנה להסתיים ולסגור את MinGW Installation Manager
7. לפתוח Sublime Text, לבחור Preferences -> Browse packages כדי לפתוח את תיקיית התוספים
8. לפתוח את התיקייה User שבפנים ולהעתיק לתוכה את הקובץ: C99 - Technion.sublime-build
9. לפתוח קובץ קוד C כלשהו, ואז לבחור Tools -> Build System -> C99 - Technion

זהו!

הוראות שימוש:
Ctrl+Shift+B כדי לבחור באיזו שיטת קומפילציה להשתמש ולקמפל
Ctrl+B כדי לקמפל בשיטה האחרונה שנבחרה


בונוס: הוספת gcc ל-PATH

אם תבצעו את זה (לא חובה) תוכלו להריץ את gcc מתוך cmd/PowerShell. ההוראות כאן הן עבור Windows 10, ייתכן גם שב-Windows בעברית חלק מהאפשרויות יהיו בעברית:
	1. לפתוח Start, להקליד PATH לחיפוש, ולפתוח את האפשרות: Edit the system environment variables.
	2. ללחוץ על הכפתור "Environment Variables..." שבתחתית החלון
	3. לסמן בחלק העליון (User variables) את האפשרות Path וללחוץ Edit...
	4. ללחוץ New ולהקליד או להדביק: C:\MinGW\bin
	5. ללחוץ OK, OK, OK
