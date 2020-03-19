using UnityEngine;

[ExecuteInEditMode]
public class ScreenPaletteEffect : MonoBehaviour
{
    public Color[] colors = new Color[4]
    {
        Color.white,
        Color.white,
        Color.white,
        Color.white
    };

    [Range(0f, 1f)]
    public float intensity = 1f;

    [Range(0f, 1f)]
    public float threshold = 0.15f;

    private Material material;

    private void Awake()
    {
        material = new Material(Shader.Find("Hidden/PaletteScreenShader"));
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (!material)
        {
            return;
        }

        material.SetFloat("_ColorCount", colors.Length);
        material.SetColorArray("_Colors", colors);
        material.SetFloat("_Intensity", intensity);
        material.SetFloat("_Threshold", threshold);

        Graphics.Blit(source, destination, material);
    }
}