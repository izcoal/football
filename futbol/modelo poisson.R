#setwd("...")
require(mgcv)

X = read.csv2("season1516.csv",header=TRUE,dec=",")
X$Date = as.Date(X$Date,"%d-%m-%Y")
div1.teams = subset(X,X$Div==1 & X$Date>=as.Date("01-08-2015","%d-%m-%Y"),select=c("HomeTeam"))
div1.teams = unique(as.vector(t(div1.teams)))

efectos = glm(goals ~ HomeTeam + AwayTeam,data=X,family = poisson())

home.effect = glm(goals ~ home_eff*Div - Div,data=X,family = poisson())

home1 = coef(home.effect)[2] + coef(home.effect)[3]
home2 = coef(home.effect)[2] + 2*coef(home.effect)[3]


# predict real madrid - girona (example) & girona - real madrid (example 2)

#example.home = exp(home1 + coef(efectos)["HomeTeamReal Madrid"] + coef(efectos)["AwayTeamGirona"])
#example.away = exp(coef(efectos)["HomeTeamGirona"] + coef(efectos)["AwayTeamReal Madrid"])

#example2.home = exp(home2 + coef(efectos)["HomeTeamGirona"] + coef(efectos)["AwayTeamReal Madrid"])
#example2.away = exp(coef(efectos)["HomeTeamReal Madrid"] + coef(efectos)["AwayTeamGirona"])

## Resultados:
#paste("El resultado Real Madrid - Girona se estima en: ",round(example.home)," - ",round(example.away))
#paste("El resultado Girona - Real Madrid se estima en: ",round(example2.home)," - ",round(example2.away))


prediccion = function(div1,params,home1,home2,hometeam,awayteam){
  
  # prediccion resultado
    home.goals = exp(ifelse(hometeam %in% div1,home1,home2) + params[paste("HomeTeam",hometeam,sep="")] + params[paste("AwayTeam",awayteam,sep="")])
    away.goals = exp(params[paste("HomeTeam",awayteam,sep="")] + params[paste("AwayTeam",hometeam,sep="")])
  
  # prediccion probabilidad resultado
    set.seed(1)
    nsim = 100000
      h.g.sim = rpois(nsim,home.goals)
      a.g.sim = rpois(nsim,away.goals)
      g.diff  = h.g.sim - a.g.sim 
        
        prob.h.win = sum(g.diff > 0)/nsim
        prob.draw  = sum(g.diff == 0)/nsim
        prob.a.win = sum(g.diff < 0)/nsim
        
  return(list(h.goals = round(home.goals),a.goals = round(away.goals),
              prob.home.win = round(prob.h.win,2),
              prob.draw = round(prob.draw,2),
              prob.away.win = round(prob.a.win,2)))
}
