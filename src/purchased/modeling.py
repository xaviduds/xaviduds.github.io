#                                                                                                      .x+=:.      .x+=:.   
#                                                                                                     z`    ^%    z`    ^%  
#  .d``            .u    .               .d``            .u    .          u.                             .   <k      .   <k 
#  @8Ne.   .u    .d88B :@8c       .u     @8Ne.   .u    .d88B :@8c   ...ue888b        .        .u       .@8Ned8"    .@8Ned8" 
#  %8888:u@88N  ="8888f8888r   ud8888.   %8888:u@88N  ="8888f8888r  888R Y888r  .udR88N    ud8888.   .@^%8888"   .@^%8888"  
#   `888I  888.   4888>'88"  :888'8888.   `888I  888.   4888>'88"   888R I888> <888'888k :888'8888. x88:  `)8b. x88:  `)8b. 
#    888I  888I   4888> '    d888 '88%"    888I  888I   4888> '     888R I888> 9888 'Y"  d888 '88%" 8888N=*8888 8888N=*8888 
#    888I  888I   4888>      8888.+"       888I  888I   4888>       888R I888> 9888      8888.+"     %8"    R88  %8"    R88 
#  uW888L  888'  .d888L .+   8888L       uW888L  888'  .d888L .+   u8888cJ888  9888      8888L        @8Wou 9%    @8Wou 9%  
# '*88888Nu88P   ^"8888*"    '8888c. .+ '*88888Nu88P   ^"8888*"     "*888*P"   ?8888u../ '8888c. .+ .888888P`   .888888P`   
# ~ '88888F`        "Y"       "88888%   ~ '88888F`        "Y"         'Y"       "8888P'   "88888%   `   ^"F     `   ^"F     
#    888 ^                      "YP'       888 ^                                  "P'       "YP'                            
#    *8E                                   *8E                                                                              
#    '8>                                   '8>                                                                              
#     "                                     "                                                                               
import numpy as np
import pandas as pd


df = pd.read_csv('05_purchased_cp.csv')
# df = pd.read_csv('src/data_programming/purchased/05_purchased_cp.csv')

print(df.head())

df['Country'] = pd.factorize(df['Country'])[0] + 1

numeric_columns = df.select_dtypes(include=[np.number]).columns
df[numeric_columns] = df[numeric_columns].fillna(df[numeric_columns].mean())

numeric_columns = df.select_dtypes(include=[np.number]).columns
df[numeric_columns] = ((df[numeric_columns] - df[numeric_columns].min())) / (df[numeric_columns].max() - df[numeric_columns].min())

df['Purchased'] = df['Purchased'].map({'Yes': 1.0, 'No': 0.0})

#    _            .       .x+=:.                                    ..    .                                s       .                              
#   u            @88>    z`    ^%                             x .d88"    @88>                             :8      @88>                            
#  88Nu.   u.    %8P        .   <k    x.    .                  5888R     %8P        ..                   .88      %8P          u.      u.    u.   
# '88888.o888c    .       .@8Ned8"  .@88k  z88u         u      '888R      .       .@88i         u       :888ooo    .     ...ue888b   x@88k u@88c. 
#  ^8888  8888  .@88u   .@^%8888"  ~"8888 ^8888      us888u.    888R    .@88u    ""%888>     us888u.  -*8888888  .@88u   888R Y888r ^"8888""8888" 
#   8888  8888 ''888E` x88:  `)8b.   8888  888R   .@88 "8888"   888R   ''888E`     '88%   .@88 "8888"   8888    ''888E`  888R I888>   8888  888R  
#   8888  8888   888E  8888N=*8888   8888  888R   9888  9888    888R     888E    ..dILr~` 9888  9888    8888      888E   888R I888>   8888  888R  
#   8888  8888   888E   %8"    R88   8888  888R   9888  9888    888R     888E   '".-%88b  9888  9888    8888      888E   888R I888>   8888  888R  
#  .8888b.888P   888E    @8Wou 9%    8888 ,888B . 9888  9888    888R     888E    @  '888k 9888  9888   .8888Lu=   888E  u8888cJ888    8888  888R  
#   ^Y8888*""    888&  .888888P`    "8888Y 8888"  9888  9888   .888B .   888&   8F   8888 9888  9888   ^%888*     888&   "*888*P"    "*88*" 8888" 
#     `Y"        R888" `   ^"F       `Y"   'YP    "888*""888"  ^*888%    R888" '8    8888 "888*""888"    'Y"      R888"    'Y"         ""   'Y"   
#                 ""                               ^Y"   ^Y'     "%       ""   '8    888F  ^Y"   ^Y'               ""                             
#                                                                               %k  <88F                                                          
#                                                                                "+:*%`                                                           
import plotly.graph_objects as go
import plotly.express as px


fig = px.scatter_3d(df, x='Country', y='Age', z='Salary', title='Salary by Country and Age', labels={'Country': 'Country', 'Age': 'Age', 'Salary': 'Salary'})
fig.write_html('3d_scatter_plot.html')

print(df.head(12))

#                                          ..          .                   s       .                              
#                                        dF           @88>                :8      @88>                            
#  .d``            .u    .              '88bu.        %8P                .88      %8P          u.      u.    u.   
#  @8Ne.   .u    .d88B :@8c       .u    '*88888bu      .          .     :888ooo    .     ...ue888b   x@88k u@88c. 
#  %8888:u@88N  ="8888f8888r   ud8888.    ^"*8888N   .@88u   .udR88N  -*8888888  .@88u   888R Y888r ^"8888""8888" 
#   `888I  888.   4888>'88"  :888'8888.  beWE "888L ''888E` <888'888k   8888    ''888E`  888R I888>   8888  888R  
#    888I  888I   4888> '    d888 '88%"  888E  888E   888E  9888 'Y"    8888      888E   888R I888>   8888  888R  
#    888I  888I   4888>      8888.+"     888E  888E   888E  9888        8888      888E   888R I888>   8888  888R  
#  uW888L  888'  .d888L .+   8888L       888E  888F   888E  9888       .8888Lu=   888E  u8888cJ888    8888  888R  
# '*88888Nu88P   ^"8888*"    '8888c. .+ .888N..888    888&  ?8888u../  ^%888*     888&   "*888*P"    "*88*" 8888" 
# ~ '88888F`        "Y"       "88888%    `"888*""     R888"  "8888P'     'Y"      R888"    'Y"         ""   'Y"   
#    888 ^                      "YP'        ""         ""      "P'                 ""                             
#    *8E                                                                                                          
#    '8>                                                                                                          
#     "                                                                                                           
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier


knn = KNeighborsClassifier(n_neighbors=3)

X = df.drop('Purchased', axis=1).values
y = df['Purchased'].values

X_train, X_test, y_train, y_test = train_test_split( X, y, test_size=0.2)
   
knn.fit(X_train, y_train)
y_pred = knn.predict(X_test)

#                            .x+=:.                        ..      s       .x+=:.   
#                           z`    ^%                 x .d88"      :8      z`    ^%  
#    .u    .                   .   <k    x.    .      5888R      .88         .   <k 
#  .d88B :@8c       .u       .@8Ned8"  .@88k  z88u    '888R     :888ooo    .@8Ned8" 
# ="8888f8888r   ud8888.   .@^%8888"  ~"8888 ^8888     888R   -*8888888  .@^%8888"  
#   4888>'88"  :888'8888. x88:  `)8b.   8888  888R     888R     8888    x88:  `)8b. 
#   4888> '    d888 '88%" 8888N=*8888   8888  888R     888R     8888    8888N=*8888 
#   4888>      8888.+"     %8"    R88   8888  888R     888R     8888     %8"    R88 
#  .d888L .+   8888L        @8Wou 9%    8888 ,888B .   888R    .8888Lu=   @8Wou 9%  
#  ^"8888*"    '8888c. .+ .888888P`    "8888Y 8888"   .888B .  ^%888*   .888888P`   
#     "Y"       "88888%   `   ^"F       `Y"   'YP     ^*888%     'Y"    `   ^"F     
#                 "YP'                                  "%                          
from sklearn.metrics import accuracy_score, f1_score


print(f'F1 Score: {f1_score(y_test, y_pred)}')
