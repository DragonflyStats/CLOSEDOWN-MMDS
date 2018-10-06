

```R
install.packages("yaImpute")
library(yaImpute)
```

    Installing package into '/home/nbcommon/R'
    (as 'lib' is unspecified)



```R
data(TallyLake)
```

#### Ground based measurements of trees (Y-variables):
* ***TopHt*** Height of tallest trees (ft)
* ***LnVolL*** Log of the volume (f t3/acre) of western larch
* ***LnVolDF*** Log of the volume (f t3/acre) of Douglas-fir
* ***LnVolLP*** Log of the volume (f t3/acre) of lodgepole pine
* ***LnVolES*** Log of the volume (f t3/acre) of Engelmann spruce
* ***LnVolAF*** Log of the volume (f t3/acre) of alpine fir
* ***LnVolPP*** Log of the volume (f t3/acre) of ponderosa pine
* ***CCover*** Canopy cover (percent)

#### Geographic Location, Slope, and Aspect (X-variables):
* ***utmx*** UTM easting at plot center
* ***utmy*** UTM northing at plot center
* ***elevm*** Mean elevation (ft) above sea level over plot
* ***eevsqrd*** (elevm − 1600)2
* ***slopem*** Mean slope (percent) over plot
* ***slpcosaspmMean*** of slope (proportion) times the cosine of aspect (see Stage (1976) for description of this transformation)
* ***slpsinaspmMean*** of slope (proportion) times the sine of aspect

#### Additional X-variables:
* ***ctim*** Mean of slope curviture over pixels in stand
* ***tmb1m*** Mean of LandSat band 1 over pixels in stand
* ***tmb2m*** Mean of LandSat band 2 over pixels in stand
* ***tmb3m*** Mean of LandSat band 3 over pixels in stand
* ***tmb4m*** Mean of LandSat band 4 over pixels in stand
* ***tmb5m*** Mean of LandSat band 5 over pixels in stand
* ***tmb6m*** Mean of LandSat band 6 over pixels in stand
* ***durm*** Mean of light duration over pixels in stand
* ***insom*** Mean of solar insolation over pixels in stand
* ***msavim*** Mean of AVI for pixels in stand
* ***ndvim*** Mean of NDVI for pixels in stand
* ***crvm*** Mean of slope curviture for pixels in stand
* ***tancrvm*** Mean of tangent curvature for pixels in stand
* ***tancrvsd*** Standard deviation of tangent curvature for pixels in stand



```R
head(TallyLake)
```


<table>
<thead><tr><th></th><th>TopHt</th><th>LnVolL</th><th>LnVolDF</th><th>LnVolLP</th><th>LnVolES</th><th>LnVolAF</th><th>LnVolPP</th><th>CCover</th><th>ctim</th><th>elevm</th><th>...</th><th>tmb6m</th><th>durm</th><th>insom</th><th>utmx</th><th>utmy</th><th>msavim</th><th>ndvim</th><th>crvm</th><th>tancrvm</th><th>tancrvsd</th></tr></thead>
<tbody>
	<tr><th>100810010001</th><td>38      </td><td>2.989211</td><td>3.230014</td><td>6.550766</td><td>1.321756</td><td>0.000000</td><td>0       </td><td>56      </td><td>2.337   </td><td>1055.099</td><td>...     </td><td>26.995  </td><td>3834.971</td><td>1091455 </td><td>237324.2</td><td>5372317 </td><td>54.091  </td><td>41.005  </td><td>32.688  </td><td>47.893  </td><td>12.184  </td></tr>
	<tr><th>100810010010</th><td>28      </td><td>3.438814</td><td>4.207971</td><td>5.498561</td><td>3.947969</td><td>3.881976</td><td>0       </td><td>72      </td><td>1.712   </td><td> 961.795</td><td>...     </td><td>32.988  </td><td>3979.433</td><td>1135193 </td><td>238273.8</td><td>5375102 </td><td>56.251  </td><td>43.006  </td><td>36.737  </td><td>60.215  </td><td>14.304  </td></tr>
	<tr><th>100810010013</th><td>87      </td><td>7.189296</td><td>6.850613</td><td>6.131531</td><td>6.631396</td><td>4.947269</td><td>0       </td><td>58      </td><td>0.695   </td><td> 970.778</td><td>...     </td><td>23.938  </td><td>3991.562</td><td>1156310 </td><td>238555.9</td><td>5375048 </td><td>53.604  </td><td>39.104  </td><td>31.271  </td><td>45.604  </td><td>12.649  </td></tr>
	<tr><th>100810010017</th><td>71      </td><td>6.242048</td><td>4.378270</td><td>8.030862</td><td>3.976499</td><td>0.000000</td><td>0       </td><td>58      </td><td>1.376   </td><td> 993.172</td><td>...     </td><td>32.572  </td><td>4039.054</td><td>1152221 </td><td>238524.2</td><td>5374100 </td><td>56.069  </td><td>42.596  </td><td>36.360  </td><td>57.576  </td><td>11.614  </td></tr>
	<tr><th>100810010018</th><td>36      </td><td>4.245061</td><td>4.255471</td><td>7.835073</td><td>0.000000</td><td>0.000000</td><td>0       </td><td>94      </td><td>1.421   </td><td>1138.569</td><td>...     </td><td>27.078  </td><td>4070.330</td><td>1194140 </td><td>238541.0</td><td>5371568 </td><td>53.835  </td><td>41.379  </td><td>33.330  </td><td>50.767  </td><td> 6.374  </td></tr>
	<tr><th>100810010019</th><td>25      </td><td>0.000000</td><td>0.000000</td><td>6.100745</td><td>0.000000</td><td>0.000000</td><td>0       </td><td>69      </td><td>1.544   </td><td> 984.898</td><td>...     </td><td>30.292  </td><td>4077.833</td><td>1167056 </td><td>238709.8</td><td>5374420 </td><td>55.000  </td><td>41.792  </td><td>35.375  </td><td>54.542  </td><td> 5.888  </td></tr>
</tbody>
</table>




```R
dim(TallyLake)
```


<ol class="list-inline">
	<li>847</li>
	<li>29</li>
</ol>


