# 主文件名（不带扩展名）
MAIN = sample701

# 默认目标：编译 PDF
all: $(MAIN).pdf

# 使用 pdflatex 编译 PDF
$(MAIN).pdf: $(MAIN).tex
	pdflatex -interaction=nonstopmode $(MAIN).tex
	bibtex $(MAIN) || true
	pdflatex -interaction=nonstopmode $(MAIN).tex
	pdflatex -interaction=nonstopmode $(MAIN).tex

# 清理临时文件
clean:
	rm -f *.aux *.bbl *.blg *.idx *.ilg *.ind *.lof *.log *.lot *.out *.toc *.fls *.fdb_latexmk *.synctex.gz

# 清理所有生成的文件，包括 PDF
cleanall: clean
	rm -f $(MAIN).pdf

# 伪目标
.PHONY: all clean cleanall