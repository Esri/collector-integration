/*
 Copyright 2016 Esri

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */


import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import com.google.gson.Gson;

import java.util.HashMap;

/**
 * <p>
 * Helper class to generate a Uri or to launch Collector for ArcGIS App.
 * </p>
 * Documented at <a href="https://github.com/ArcGIS/collector-integration#documentation">Collector integration</a>
 */
public final class CollectorUrlSchemeUtil {
    private static final String COLLECTOR_URI = "com.esri.arcgis.collector";

    private static final String ARCGIS_COLLECTOR_SCHEME = "arcgis-collector";

    private static final String MAP_ITEM_ID = "itemID";

    private static final String MAP_CENTER = "center";

    private static final String MAP_FEATURE_SOURCE_URL = "featureSourceURL";

    private static final String MAP_FEATURE_ATTRIBUTES = "featureAttributes";

    /**
     * The constructor is made private because this class is only intended to be used with its static methods
     */
    private CollectorUrlSchemeUtil() {
    }

    /**
     * Convenience method to test whether the Collector application is installed on the device or not
     *
     * @param context an application context
     * @return true if Collector is installed on the device, false otherwise
     */
    public static boolean isCollectorInstalled(Context context) {
        PackageManager pm = context.getPackageManager();
        try {
            pm.getPackageInfo(COLLECTOR_URI, PackageManager.GET_ACTIVITIES);
            return true;
        } catch (PackageManager.NameNotFoundException ignore) {
        }

        return false;
    }


    /**
     * Open the specified map in Collector for ArcGIS.
     *
     * @param activity  the activity launching Collector for ArcGIS.
     * @param mapItemId The web map item ID to open within Collector.
     * @param mapCenter Specified as a set of latitude, longitude (y,x) coordinates. Coordinates must be in WGS84 coordinates. (optional)
     * @throws IllegalArgumentException if the map item id passed in is null or empty
     */
    public static void openMapInCollector(Activity activity, String mapItemId, String mapCenter, String featureSourceURL, HashMap<String,Object> featureAttributes) {
        Uri uriBuilder = generateUri(mapItemId, mapCenter, featureSourceURL, featureAttributes);

        Intent mapIntent = new Intent(Intent.ACTION_VIEW, uriBuilder);
        activity.startActivity(mapIntent);
    }

    /**
     * Open the specified map in Collector for ArcGIS.
     *
     * @param activity  the activity launching Collector for ArcGIS.
     * @param collectorURIScheme A properly formatted Uri to launch Collector
     */
    public static void openMapInCollector(Activity activity, Uri collectorURIScheme) {
        Intent mapIntent = new Intent(Intent.ACTION_VIEW, collectorURIScheme);
        activity.startActivity(mapIntent);
    }

    /**
     * Generate a Uri to launch Collector for ArcGIS App.
     *
     * @param mapItemId The web map item ID to open within Collector.
     * @param mapCenter Specified as a set of latitude, longitude (y,x) coordinates. Coordinates must be in WGS84 coordinates. (optional)
     * @return A properly formatted Uri to launch Collector
     * @throws IllegalArgumentException if the map item id passed in is null or empty
     */
    public static Uri generateUri(String mapItemId, String mapCenter, String featureSourceURL, HashMap<String, Object> featureAttributes) {
        if (mapItemId == null || mapItemId.isEmpty()) {
            throw new IllegalArgumentException("You must pass in a valid map item id");
        }

        Uri.Builder uriBuilder = new Uri.Builder();

        uriBuilder.scheme(ARCGIS_COLLECTOR_SCHEME);
        uriBuilder.authority("");
        uriBuilder.appendQueryParameter(MAP_ITEM_ID, mapItemId);
        uriBuilder.appendQueryParameter(MAP_CENTER, mapCenter);
        uriBuilder.appendQueryParameter(MAP_FEATURE_SOURCE_URL, featureSourceURL);

        String featureAttributeString = new Gson().toJson(featureAttributes);
        uriBuilder.appendQueryParameter(MAP_FEATURE_ATTRIBUTES, featureAttributeString);
        
        return uriBuilder.build();
    }
}
