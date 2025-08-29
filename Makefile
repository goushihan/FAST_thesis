# 主文件名（不带扩展名）
MAIN := main

# 章节与参考文献
SECTIONS := $(wildcard sections/*.tex)
BIBFILE  := $(wildcard *.bib)

TEXFLAGS := -interaction=nonstopmode -halt-on-error

# 默认目标：编译 PDF
all: $(MAIN).pdf

# 当主文件、任何章节或 .bib 变更时触发重编译
$(MAIN).pdf: $(MAIN).tex $(SECTIONS) $(BIBFILE)
	pdflatex $(TEXFLAGS) $(MAIN).tex
	if [ -n "$(BIBFILE)" ]; then bibtex $(MAIN) || true; fi
	pdflatex $(TEXFLAGS) $(MAIN).tex
	pdflatex $(TEXFLAGS) $(MAIN).tex

# 清理临时文件（包含 sections 下可能生成的文件）
clean:
	rm -f *.aux *.bbl *.blg *.idx *.ilg *.ind *.lof *.log *.lot *.out *.toc *.fls *.fdb_latexmk *.synctex.gz
	rm -f sections/*.aux sections/*.log sections/*.out

# 清理所有生成的文件，包括 PDF
cleanall: clean
	rm -f $(MAIN).pdf

# 伪目标
.PHONY: all clean cleanall