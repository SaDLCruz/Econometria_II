**				   **
* MODELO VAR - VEC  *
* ANÁLISIS EMPIRICO *
**				   **

global datos "/Users/macbookait/Documents/UNIPAMPLONA/CURSOS/Econometría/Econometría II/Modelo VAR - VEC/Datos"
import excel "${datos}/bd_price.xlsx", sheet("Hoja1") firstrow

gen date=ym(year,moth)
*733*
tsset date, monthly

#delimit;
		tsline price_antioaquia price_atlantico,
		ytitle("Precio leche cruda""")
		xtitle("Meses")
		xscale(lwidth(thick) lcolor(black))
		xscale(lwidth(thin) lcolor(black))
		tline(2012m3)
		plotregion(color(white))
		graphregion(color(white) lcolor(white));


local price price_antioaquia price_atlantico

foreach x of local price {
		dfuller `x', nocons regress
		dfuller `x', regress
		dfuller `x', trend regress
 }

local price price_antioaquia price_atlantico

foreach x of local price {
		gen di`x'=D.`x'
		}
 
var diprice_antioaquia diprice_atlantico
varsoc, maxlag(10)
varsoc, maxlag(15)
varsoc, maxlag(5)
varsoc, luts

	vecrank price_antioaquia price_atlantico, lags(2)

	var price_antioaquia price_atlantico, lags(2) // VAR

	vec price_atlantico price_antioaquia, lag(2)
	vec price_atlantico price_antioaquia, lag(2) alpha
	vecstable, graph
	
	qui vec price_atlantico price_antioaquia, lag(2)
	fcast compute p_1, step(12)
	fcast graph p_1price_atlantico p_1price_antioaquia
	
	
	irf set "vec.irf"
    irf create vec1, replace step (12)
	irf graph irf
	irf graph irf, impulse (price_antioaquia) response (price_atlantico) yline(0.05)
	graph save Graph "IRF1", replace
	
	irf graph irf, impulse (price_atlantico) response (price_antioaquia) yline(0.05)
	graph save Graph "IRF2", replace
	
	graph combine "IRF1.gph""IRF2.gph", col(2) rows(3)



