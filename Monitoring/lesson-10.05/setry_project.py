import sentry_sdk
sentry_sdk.init(
    "https://bd79f8adda22460cafb11b9b26c1d9c9@o1132432.ingest.sentry.io/6178012",
    traces_sample_rate=1.0
)

if __name__ == '__main__' : 
    division_by_zero = 1 / 0