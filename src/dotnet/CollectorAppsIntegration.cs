using System;
using System.Text;
using Windows.Foundation;
using Windows.System;

namespace AppsIntegration
{
  /// <summary>
  /// Helper class to generate a Uri or to launch Collector for ArcGIS App.
  /// </summary>
  /// Documented at https://github.com/ArcGIS/collector-integration#documentation />
  public static class Collector
  {
    const string Protocol = "arcgis-collector://";

    /// <summary>
    /// Generate a Uri to launch Collector for ArcGIS App.
    /// </summary>
    /// <example>
    /// Launcher.LaunchUriAsync(Collector.GenerateUriScheme());
    /// </example>
    /// <returns>A properly formatted Uri to launch Collector</returns>
    public static Uri GenerateUriScheme()
    {
      return new Uri(Protocol);
    }

    /// <summary>
    /// Generate a Uri to launch Collector for ArcGIS App.
    /// </summary>
    /// <example>
    /// Launcher.LaunchUriAsync(Collector.GenerateUriScheme(itemID:"35b1ccecf226485ea7d593f100996b49", center:"34.0547155,-117.1961714"));
    /// </example>
    /// <param name="itemID">The web map to open within Collector.</param>
    /// <param name="center">Specified as a set of latitude, longitude (y,x) coordinates. Coordinates must be in WGS84 coordinates. (optional)</param>
    /// <returns>A properly formatted Uri to launch Collector</returns>
    public static Uri GenerateUriScheme(string itemID, string center = null)
    {
      if (string.IsNullOrEmpty(itemID))
        throw new ArgumentNullException("itemID");

      var urlBuilder = new StringBuilder($"{Protocol}?itemID={itemID}");
      if (!string.IsNullOrEmpty(center))
        urlBuilder.Append($"&center={center}");

      return new Uri(urlBuilder.ToString());
    }

    /// <summary>
    /// Launch Collector for ArcGIS App.
    /// </summary>
    /// <example>
    /// Collector.Launch();
    /// </example>
    public static IAsyncOperation<System.Boolean> Launch()
    {
      return Launcher.LaunchUriAsync(GenerateUriScheme());
    }

    /// <summary>
    /// Launch Collector for ArcGIS App.
    /// </summary>
    /// <example>
    /// Collector.Launch(itemID:"35b1ccecf226485ea7d593f100996b49", center:"34.0547155,-117.1961714");
    /// </example>
    /// <param name="itemID">The web map to open within Collector.</param>
    /// <param name="center">Specified as a set of latitude, longitude (y,x) coordinates. Coordinates must be in WGS84 coordinates. (optional)</param>
    public static IAsyncOperation<System.Boolean> Launch(string itemID, string center = null)
    {
      return Launcher.LaunchUriAsync(GenerateUriScheme(itemID, center));
    }
  }
}
